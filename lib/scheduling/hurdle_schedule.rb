module HurdleSchedule
	
	def generate(tour)
		events = tour.events
		
		if events.count == 0
			Rails.logger.debug("debug::" +"day1")
			return day1(tour)
		end
		
		round = getNextRound(tour) 
		return round if round.is_a? String
		
		if round == 1
			Rails.logger.debug("debug::" +"day2")
			return day2(tour, 2)
		else
			#Rails.logger.debug("debug::" +"day %d", round)
			return dayN(tour, round)
		end
		
		return "Did nothing. #{events.count} events found & next round is ##{round}"
		
	end

	def day1(tour)
	
	'''	Get a list of all hurdlers without times and schedule them for races.
		Lane allocation is random.
		
		Also creates entire tournaments events, which latter days schedules
		 use.
		
		'''
		#Get all players in the tournament without a previous time.
		players_with_no_time = HurdlePlayer.where(:tournament_id => tour.id, :previous_time => nil)
		
		#Get all players
		players = HurdlePlayer.where(:tournament_id => tour.id)
		return "No players registered for the tournament." if players.empty?
		
		#Find number of rounds & numbers of players in each.
		#Create array of rounds, storing number of players in each round.
		rounds = [players_with_no_time.size, players.size]
		if players.size > 8
			begin
				unless players.size < 16
					x = players.size / 2
					if x%8 != 0
						x += 8 - (x%8)
					end
					players = players[0,x]
				else
	              players = players[0,8]
			   end
			   rounds.append(players.size)
			end until players.size <= 8
		end
		
		#Make the blank tournaments events.
		makeBlankEvents(tour, rounds)
		
		#If there are no players with no time, go straight to day2
		return day2(tour, 1) if players_with_no_time.empty?
		
		
		#To randomise lanes, shuffle players.
		players_with_no_time.shuffle
		
		#Split into n heats as evenly as possible.
		heats = players_with_no_time.in_groups((players_with_no_time.size/8.0).ceil, false)
		
		for heat in heats
			fillHeat(heat, 1, tour)
		end
		
		return "Hurdle schedule success: #{heats.length} events scheduled over #{rounds.size} rounds"
	end
	
	def day2(tour, round)
		#Everyone races
		#Uneven number of athletes
		#Random lanes
		message = "Hurdle day 2 success."
		#Get all players
		#Shuffle to randomise lanes.
		players = HurdlePlayer.where(:tournament_id => tour.id).shuffle
	
		#Split into n heats as evenly as possible.
		heats = players.in_groups((players.size/8.0).ceil, false)

		for heat in heats
			m = fillHeat(heat, round, tour)
			message = m if m != nil
		end
		
		return 
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
		
		return "DayN success, round #{round+1} scheduled."
	end
	
	def fillHeat (players, round, tour)
		'''Find a blank heat in tournament Tour, with round number Round.
		  *Assumes players are in lane order, 1->8.
		  *Fill it with players.'''
		  
		
		#Get all blank events, then sort them by start date, soonest at the top
		blankEvent = tour.events.where(:round => round, :status => "pending")
		blankEvent.sort_by!{|u| u.start }
		
		return "End of tournament: No blank heats to fill in" if blankEvent.empty?
		
		blankEvent = blankEvent.first
		
		players.each_with_index do |player, lane|
			ht = HurdleTime.new({:lane => (lane+1)})
			ht.time = nil
			ht.hurdle_match_id = blankEvent.hurdle_match.id
			ht.hurdle_player_id = player.id
			ht.save
			freeTicket(tour, player, blankEvent
			)
		end
		
		blankEvent.status = "scheduled"
		blankEvent.save
		
		return nil
	end
	
	
	def makeBlankEvents(tour, rounds)
		#rounds index = round, rounds[x] = numbers of players in that round.
		#Eg. rounds = [10, 32, 16, 8]
		#First number may be lower as day 0 gets a time for players without one.
		rounds.shift if rounds.first == 0
			
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
			((rounds[index] / 8.0).ceil).times do
				time = getNextTime(times, tour, gTs, index+1)
				times.append(makeBlankHeat(tour, index+1, time))
				times.sort_by!{|t|t.start}
			end
		end
		
	end
	
	def makeBlankHeat(tour, round, time)
		event = Event.new({:status => "pending", :tournament_id => tour.id, :round => round, :start => time})

        if Venue.count < 1
          return "Must create a venue before making a schedule"
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
						return "All times just be filled before the players in the next round can be decided."
					end
				end
			end
			
			#Check if the next round has no heats filled in
			
			if tour.events.where(:round => round+1).first.hurdle_match.hurdle_times.empty?
				return round
			end
		end
		
		#Something really weird just happened.
		return "This error should not occur.\n Scheduling has failed at: \nfunction: getNextRound"
	end
	
	def freeTicket(tour, player, event)
		tickets = player.user.tickets
		eStart = event.start.to_date
		
		issuedTickets = player.user.tickets.where(:status => "Free")
		issuedTickets.sort_by!{|u|u.start}
		unless issuedTickets.empty?
			issuedTickets.each do |x|
				return nil if x.start == eStart
			end
		end
		
		2.times do
			t = Ticket.new
			t.start = eStart
			t.user_id = player.user_id
			t.status = "Free"
			t.competition_id = tour.competition_id
			t.adults = 1
			t.concessions = 0
			t.save
		end
		
	end
	
	module_function :generate, :roundConflict, :getUsedTimes, :freeTicket,:getNextTime, :makeBlankEvents, :makeBlankHeat, :dayN, :day2, :day1, :getNextTime, :getNextRound, :fillHeat
end
	
	

