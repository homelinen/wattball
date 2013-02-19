require 'faker'
require 'factory_girl'

# Need to require the Dummy Generator class, or move this into a factories.rb

class Dummy

  # For the model get a random one
  #
  def self.getRandom(model)
    # Make sure the table has been initialised
    if model.table_exists?
        models = model.all

        models[rand(models.length)]
    end
  end

  def self.get_random_where(model, where)
    models = model.where(where)

    if models.length > 0
      models[rand(models.length)]
    else
      nil
    end
  end
end

FactoryGirl.define do
  sequence :time do |n|

    # Start at 10 am
    earliest = 10
    if n.hour + earliest > 18
      n = 0
    end
    hour = n.hour + earliest

    Time.at(hour + rand(60).minutes)
  end

  factory :event do
    start { generate(:time) }
    date { 2.months.from_now + rand(12).days }
    status 'Scheduled'

    # This will create a new official for every event
    official
    tournament { Tournament.all.sample }
  end

  factory :wattball_match do
    event
    team1 { Team.all.sample }
    team2 { Team.all.sample }
  end

  factory :tournament do
    name 'Wattball Tournament'
    startDate { 2.weeks.from_now }
    endDate { 4.weeks.from_now }
    sport

    max_competitors 5
    adult_ticket_price 9.20
    concession_ticket_price 5.40
  end

  factory :sport do
    name 'Wattball'
    length '90'
  end

  factory :hurdle_match do
    event
  end

  factory :hurdle_times do
    athlete { Dummy.getRandom(HurdlePlayer) }
    hurdle_match { Dummy.getRandom(HurdleMatch) }

    time { Time.at(1.minute + rand(60).seconds) }
    lane { rand(9) }
  end

  factory :score do
    match = Dummy.getRandom(WattballMatch) 
    event { match.event }
    # Pick a random player from this events teams, this is maybe a model method
    wattball_player { WattballPlayer.where("team_id = ? OR team_id = ?", match.team1_id, match.team2_id).sample }
    amount { rand(4) }
  end

  factory :sport_center do
    name = "Heriot Watt Sport Center"
    email = "sport-center@hw.ac.uk"
    address_line1 "Heriot-Watt University"
    address_line2 "Edinburgh Campus"
    address_city "Edinburgh"
    address_postcode "EH14 4AS"
    contact 
  end
end
