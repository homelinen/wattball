require 'rrschedule'
require 'date'

module RoundRobin


	def generate(tour)
	
		#Test generator
		#create schedule using teams in the db
		#static start date
		#Get all the teams
		
		#tour = Tournament.joins(:sport).where("sports.name = 'Wattball'").first
		
		teams = tour.teams
		return "No teams registered to play in this tournament." if teams.empty?
		
		start = tour.startDate
		
		#Get fields names
		fields = Venue.joins(:sport).where("sports.name = 'Wattball'")
		return "No venue. Please add a venue for the sport to schedule matches." if fields.empty?
		
		schedule = RRSchedule::Schedule.new(
			:teams => teams,
			:rules => [
						RRSchedule::Rule.new(
							:wday => 0,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						),
						RRSchedule::Rule.new(
							:wday => 1,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						),
						RRSchedule::Rule.new(
							:wday => 2,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						),
						RRSchedule::Rule.new(
							:wday => 3,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						),
						RRSchedule::Rule.new(
							:wday => 4,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						),
						RRSchedule::Rule.new(
							:wday => 5,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						),
						RRSchedule::Rule.new(
							:wday => 6,
							:gt => ["11:00AM","02:00PM"],
							:ps => fields
						)
						],
			:start_date => start
		).generate
		
		#Uncomment next line to print schedule to command prompt.
		#puts schedule.to_s 
		
		schedule.gamedays.each do |gd|
			gd.games.each do |game|
				event = Event.new(:start => DateTime.parse("#{gd.date} #{game.gt}"), :tournament_id => tour.id)
				event.venue = game.ps
				event.status = "scheduled"
				event.save
				
				match = WattballMatch.new(:team1 => game.team_a, :team2 => game.team_b)
				match.event_id = event.id
				match.save
				
				event.wattball_match = match
				
				
				freeTicket(tour, match.team1.user, event)
				freeTicket(tour, match.team2.user, event)
				
				#Event.create(:date => game.gt.strftime("%D"), :end => (game.gt + 90.minutes).strftime("%H:%M"), :start => game.gt.strftime("%H:%M"), :tournament_id => tour.id)
				
			end
		end
		
		return "Round-Robin type scheduling successful."

	end
	
	def freeTicket(tour, player, event)
		eStart = event.start.to_date
		
		issuedTickets = player.tickets.where(:status => "Free")
		issuedTickets.sort_by!{|u|u.start}
		unless issuedTickets.empty?
			issuedTickets.each do |x|
				return nil if x.start == eStart
			end
		end
		
		25.times do
			t = Ticket.new
			t.start = eStart
			t.user_id = player.id
			t.status = "Free"
			t.competition_id = tour.competition_id
			t.adults = 1
			t.concessions = 0
			t.save
		end
		
	end
	
	module_function :generate, :freeTicket

end



