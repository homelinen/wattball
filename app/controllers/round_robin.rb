require 'rrschedule'
require 'date'

module RoundRobin


	def generate
	
		#Test generator
		#create schedule using teams in the db
		#static start date
		#Get all the teams
		
		#tour = Tournament.joins(:sport).where("sports.name = 'Wattball'").first
		tour = params[:tournament]
		
		teams = Team.all

		#Get tournament start date {Impossible}
		
		start = tour.startDate
		
		#Get fields names
		fields = Venue.joins(:sport).where("sports.name = 'Wattball'")
		
		schedule = RRSchedule::Schedule.new(
			:teams => teams,
			:rules => [
						RRSchedule::Rule.new(
							:wday => 6,
							:gt => ["11:00AM","01:00PM"],
							:ps => fields
						)
						],
			:start_date => start
		).generate
		
		#Uncomment next line to print schedule to command prompt.
		#puts schedule.to_s 
		
		schedule.gamedays.each do |gd|
			gd.games.each do |game|
				match = WattballMatch.create(:team1 => game.team_a, :team2 => game.team_b)
				Event.create(:date => game.gt.strftime("%D"), :end => (game.gt + 90.minutes).strftime("%H:%M"), :start => game.gt.strftime("%H:%M"), :tournament_id => tour.id)
			end
		end
		
		
		
		
		
	end

	def genFake
	
	schedule=RRSchedule::Schedule.new(:teams => [
		%w(A1 A2 A3 A4 A5 A6 A7 A8),
		%w(B1 B2 B3 B4 B5 B6 B7 B8)
	  ],

	  #Setup some scheduling rules
	  :rules => [
		RRSchedule::Rule.new(:wday => 3, :gt => ["7:00PM","9:00PM"], :ps => ["field #1", "field #2"]),
		RRSchedule::Rule.new(:wday => 5, :gt => ["7:00PM"], :ps => ["field #1"])
	  ],

	  #First games are played on...
	  :start_date => Date.parse("2010/10/13"),

	  #array of dates to exclude
	  :exclude_dates => [Date.parse("2010/11/24"),Date.parse("2010/12/15")],

	  #Number of times each team must play against each other (default is 1)
	  :cycles => 1,

	  #Shuffle team order before each cycle. Default is true
	  :shuffle => true
	)

	schedule.generate
	puts schedule.to_s
		
	end

end



