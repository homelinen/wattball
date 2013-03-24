module HurdleSchedule
	
	def generate(tour)
		events = tour.events
		
		if events.count == 0
			Rails.logger.debug("debug::" +"day1")
			day1(tour)
			return 0
		end
		
		round = getNextRound(tour) 
		
		if round == 1
			Rails.logger.debug("debug::" +"day2")
			day2(tour)
			return 0
		else
			#Rails.logger.debug("debug::" +"day %d", round)
			dayN(tour, round)
			return 0
		end
		
	end

	def day1(tour)
	
	'''	Get a list of all hurdlers without times and schedule them for races.
		Lane allocation is random.
		
		Also creates entire tournaments events, which latter days scheules
		 use.
		
		'''
		#Get all players in the tournament without a previous time.
		players_with_no_time = HurdlePlayer.where(:tournament_id => tour.id, :previous_time => nil)
		
		#Get all players
		players = HurdlePlayer.where(:tournament_id => tour.id)
		
		#Find number of rounds & numbers of players in each.
		#Create array of rounds, storing number of players in each round.
		rounds = [players_with_no_time.size]
		until players.size == 8 do
			rounds.append(players.size)
			unless players.size < 16
				x = players.size / 2
				if x%8 != 0
					x += 8 - (x%8)
				end
				players = players[0,x]
			else
              players = players[0,8]
		   end
		end
		rounds.append(8)
		
		#Make the blank tournaments events.
		makeBlankEvents(tour, rounds)
		
		#If there are no players with no time, go straight to day2
		if rounds[0] == 0
			day2(tour)
			return nil
		end
		
		#To randomise lanes, shuffle players.
		players_with_no_time.shuffle
		
		#Split into n heats as evenly as possible.
		heats = players_with_no_time.in_groups((players_with_no_time.size/8.0).ceil, false)
		
		for heat in heats
			fillHeat(heat, 1, tour)
		end
	
	end
	
	def day2(tour)
		#Everyone races
		#Uneven number of athletes
		#Random lanes
		
		#Get all players
		#Shuffle to randomise lanes.
		players = HurdlePlayer.where(:tournament_id => tour.id).shuffle
	
		#Split into n heats as evenly as possible.
		heats = players.in_groups((players.size/8.0).ceil, false)
		
        round = getNextRound(tour)+1
		for heat in heats
			fillHeat(heat, round, tour)
		end
	end
	
	def dayN(tour, round)
		#get (players / 2) + ((players / 2) % 8) fastest players from day N-1.
		players = []
		
		tour.events.where(:round => round).each do |ev|
			ev.hurdle_match.hurdle_times.each do |t|
				players.append(t.hurdle_player)
	        end
	    end
	    
	    #Sort players by previous time
		players.sort_by!{|u| u.previous_time }
		
		#Bug: Does not deal with tied last place times.
		#Get top 50% of players + enough to fill all 8 lanes of each heat.
		unless players.size < 16
			x = players.size / 2
			
			x += 8 - (x % 8) if x%8 != 0
			
			players = players[0, x]
		else
			players = players[0,8]
		end
		
		
		#Creates a 2D array, 8 columns by number of heats needed rows.
		#Each column holds a list fo players running on a the index lane.
		#Each row hense holds the players in a heat.
		seq = [3, 4, 2, 5, 1, 6, 0, 7]
		rounds = Array.new(8) { Array.new((players.size / 8)) }
		p = 0
		rounds.each_with_index do |lane, laneIndex|
			lane.each_with_index do |heat, heatIndex|
				rounds[seq[laneIndex]][heatIndex] = players[p]
				p+=1
			end
		end
		
		#Collect all players in a heat into a single array and pass it to ::fillHeat
		heat = Array.new(8)
		# do number of heats times
		(0...(rounds[0].count)).to_a.each do |x| 
			#do 8 times
			8.times do |y|
				heat[y] = rounds[y][x]
			end
			fillHeat(heat, round+1, tour)
		end
	end
	
	def fillHeat (players, round, tour)
		'''Find a blank heat in tournament Tour, with round number Round.
		  *Assumes players are in lane order, 1->8.
		  *Fill it with players.'''
		  
		
		#Get all blank events, then sort them by start date, soonest at the top
		blankEvent = tour.events.where(:round => round, :status => "pending")
		blankEvent.sort_by!{|u| u.start }
		
		blankEvent = blankEvent.first
		
		players.each_with_index do |player, lane|
			ht = HurdleTime.new({:lane => (lane+1)})
			ht.time = nil
			ht.hurdle_match_id = blankEvent.hurdle_match.id
			ht.hurdle_player_id = player.id
			ht.save
		end
		
		blankEvent.status = "scheduled"
		blankEvent.save
	end
	
	def makeBlankEvents(tour, rounds)
		#rounds index = round, rounds[x] = numbers of players in that round.
		#Eg. rounds = [10, 32, 16, 8]
		#First number may be lower as day 0 gets a time for players without one.
	
		#Makes all needed blank events for the tournament.
		#round number round?, associated to tour
		#status => "pending"
		#blank hurdle_match associated to it.
			
		#Create a list of times where the venues are used.
		times = getUsedTimes(tour)
		
		#Create an array of times when matches may be started
		#every 20 minutes from 10:00am until 4am, excluding 12:00pm > 1:00pm
		gTs = []
		x = 10.hours
		duration = tour.sport.length.minutes
		begin 
			gTs.append(x) unless ((x > 12.hours) and (x < 13.hours))
			x+=duration
		end while gTs.last < (16.hours - duration)
		
		
		rounds.each_with_index do |round, index|
			(round / 8).times do
				time = getNextTime(times, tour, gTs, index+1)
				times.append(makeBlankHeat(tour, index+1, time))
				times.sort_by!{|t|t.start}
			end
		end
		
	end
	
	def makeBlankHeat(tour, round, time)
		event = Event.new({:status => "pending", :tournament_id => tour.id, :round => round, :start => time})

        if Venue.count < 1
          raise "Must create a venue before making a schedule"
        end

		ven = tour.sport.venues.first
		event.venue_id = ven.id
		event.save
		
		hm = HurdleMatch.new({})
		hm.event_id = event.id
		hm.save
		
		return event
	end
	
	def getNextTime(usedTimes, tour, gameTimes, round)
		time = tour.startDate
		startDate = time.to_datetime
		duration = (tour.sport.length).minutes
		
		startDate += roundConflict(round, tour, startDate)
		#Test if the first time is below the first used time
		# or above the last used time.
		firstTime = startDate.to_datetime + gameTimes.first
		return firstTime if usedTimes.length == 0
		return firstTime if (firstTime + duration) < (usedTimes.first.start)
		
		
		
		begin
			gameTimes.each do |gt|
				time = startDate + gt
				
				#If time is now beyond the last event
				return time if time > (usedTimes.last.start + duration) 
				
				usedTimes.each_with_index do |usedTime, index|
				
					endTime = usedTime.start + duration
					
					#If time is within usedTime's slot or ends within usedTime's slot
					next if (time.between?(usedTime.start, endTime) or (time + duration).between?(usedTime.start, endTime))
					
					#If it's higher than the current, and lower than the next, return it.
					nextUsedTime = usedTimes[index+1]
					next if nextUsedTime == nil
					
					#time is valid if it starts after the usedTime ends and ends before the next event starts.
					return time if (time > endTime) and ((time + duration) < nextUsedTime.start)
				end
			end
			startDate += 1.day
			startDate += roundConflict(round, tour, startDate)
		end while true
		''' Issues:
				use of a single duration value prevents use of single
				venue by multiple sports.
				
				if event ends on the same minute
		'''
		
	end
	
	def roundConflict(round, tour, time)
		#Returns number of days to move forward because of conflicts due to
		# Req: A person should not race more than once per day
		usedTimes = tour.events.where('events.round not in (?)', round)
		usedTimes.uniq!{|u|u.start.to_date}
		usedTimes.sort_by!{|u|u}.reverse!
		added = 0
		
		time = time.to_date
		until(usedTimes.select{|u|u.start.to_date == time}).empty?
			time += 1.day
			added += 1
		end 
		return added.days
	end
	
	def getUsedTimes(tour)
	
		pitchs = tour.sport.venues
	
		#Get all the times the venues are in use
		
		
		times = []
		pitchs.each do |pitch|
			#times.append(Event.where(:venue_id => pitch))
			pitch.events.each do |event|
				times << event
			end
		end
		
		#Remove duplicates and sort in decending order.
		times.uniq!
		times.sort_by!{|h|h.start}
		
		#Find any times below the start date and cut them off.
		outOfBound = nil
		times.each_with_index do |event, index|
			if ( (event.start + tour.sport.length.minutes) < tour.startDate)
				outOfBound = index
			end
		end
		
		times.slice!(outOfBound+1, a.size-1) unless outOfBound == nil
		return times
	end
	
	def getNextRound(tour) 
		max = tour.events.maximum(:round)
		currentRound = nil
		
		max.times do |round|
			round+=1
			
			#Need a round where there are no nil hurdle_time.time
			#And the next round contains only blank heats.
			
			events = tour.events.where(:round => round)
			
			#Check if the current rounds times are all filled in.
			#Error a round with a nil hurdle time is found.
			events.each do |event|
				event.hurdle_match.hurdle_times.each do |t|
					if t.time == nil
						raise "Event has nil time. All times just be filled before the players in the next round can be decided."
					end
				end
			end
			
			#Check if the next round has no heats filled in
			
			if tour.events.where(:round => round+1).first.hurdle_match.hurdle_times.empty?
				return round
			end
		end
		
		#Something really weird just happened.
		raise "This error should not occur.\n Scheduling has failed at: \nfunction: getNextRound"
	end
	module_function :generate, :roundConflict, :getUsedTimes, :getNextTime, :makeBlankEvents, :makeBlankHeat, :dayN, :day2, :day1, :getNextTime
end
	
	

