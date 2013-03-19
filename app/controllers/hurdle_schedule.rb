def day1

'''	Get a list of all hurdlers without times and schedule them for races.
	Lane allocation is random.
	
	Also creates entire tournaments events, which latter days scheules
	 use.
	
	'''
	
	#Get the tournament.
	tour = params[:tournament]
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
	rounds.each_with_index do |round, index|
		(round / 8).times do
			makeBlankHeat(Tournament, index)
		end
	end
	
	#To randomise lanes, shuffle players.
	players_with_no_time.shuffle
	
	#Split into n heats as evenly as possible.
	heats = players_with_no_time.in_groups((players_with_no_time.size/8.0).ceil, false)
	
	for heat in heats
		makeHeat(heat, 0)
	end

end

def day2
	#Everyone races
	#Uneven number of athletes
	#Random lanes
	tour = params[:tournament]
	
	#Get all players
	#Shuffle to randomise lanes.
	players = HurdlePlayer.where(:tournament_id => tour.id).shuffle

	#Split into n heats as evenly as possible.
	heats = players.in_groups((players.size/8.0).ceil, false)
	
	for heat in heats
		fillHeat(players, 1, tour)
	end
end

def dayN
	#get (players / 2) + ((players / 2) % 8) fastest players from day N-1.
	tour = params[:tournament]
	max = tour.events.maximum(:round)
	players = []
	
	for event in tour.events.where(:round => max) do
        for t in ev.hurdle_match.hurdle_times do
            players.append(t.hurdle_player)
        end
    end
    
    #Sort players by previous time
	players.sort_by!{|u| u.previous_time }
	
	#Bug: Does not deal with tied last place times.
	#Get top 50% of players + enough to fill all 8 lanes of each heat.
	unless players.size < 16
		x = players.size / 2
		if x%8 != 0
			x += 8 - (x % 8)
		end
		
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
	
	#Collect all players in a heat into a single array and pass it to #makeHeat
	heat = Array.new(8)
	# do number of heats times
	for x in 0...(rounds[0].count) do 
		#do 8 times
		for y in 0...8 do
			heat[y] = rounds[y][x]
		end
		fillHeat(heat, max+1, tour)
	end
end


def fillHeat (players, round, tour)
	'''Find a blank heat in tournament Tour, with round number Round.
	  *Assumes players are in lane order, 1->8.
	  *Fill it with players.'''
	
	#Get all blank events, then sort them by start date, soonest at the top.
	blankEvent = tour.events.where(:round => round, :status => "pending")
	blankEvent.sort_by!{|u| u.start }
	blankEvent = blankEvent[0]
	
	players.each_with_index do |player, lane|
		HurdleTime.create({:lane => (lane+1), :hurdle_player_id => player.id, :hurdle_match_id => blankEvent.hurdle_match.id, :time => nil})
	end
	
	blankEvent.status = "scheduled"
	blankEvent.save
end


def makeBlankHeat(tour, round)
	#Makes a new blank event at the next free date.
	#round number round?, associated to tour
	#status => "pending"
	#blank hurdle_match associated to it.
	
end
