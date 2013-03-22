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
    start { generate(:time) + 1.months.from_now + rand(12).days }
    status 'scheduled'

    # This will create a new official for every event
    official
    tournament { Tournament.all.sample || FactoryGirl.create(:tournament) }
    venue { Venue.find(:first, :offset => rand(Venue.count)) || FactoryGirl.create(:venue) }
  end

  factory :wattball_match do
    association event, status: 'played'
    team1 { Dummy.getRandom(Team) || FactoryGirl.build(:team) }
    team2 { Dummy.getRandom(Team) || FactoryGirl.build(:team) }
  end

  factory :competition do
    name "Tournaments"
    ticket_limit 2000
    adult_price 7.20
    concession_price 5.40
  end

  factory :tournament do
    name 'Wattball Tournament'
    startDate { 2.weeks.from_now }
    endDate { 4.weeks.from_now }
    sport

    max_competitors 5
    competition { Competition.first || FactoryGirl.create(:competition) }
  end

  factory :venue do
    capacity { [10, 500 , 1000, 2000].sample }
    name { %w( Frontier Barrier Forklon ).sample + " Stadium" }
    sport { Dummy.getRandom(Sport) || FactoryGirl.create(:sport) }
    sport_center { Dummy.getRandom(SportCenter) || FactoryGirl.create(:sport_center) }
  end

  factory :sport do
    name 'Wattball'
    length '90'
  end

  factory :hurdle_match do
    event
  end

  factory :hurdle_time do
    hurdle_player { Dummy.getRandom(HurdlePlayer) }
    hurdle_match { Dummy.getRandom(HurdleMatch) }

    time { Time.at(1.minute + rand(60).seconds) }
    lane { rand(9) }
  end

  factory :score do
    wattball_match { Dummy.getRandom(WattballMatch) || FactoryGirl.create(:wattball_match) 
 }
    # Pick a random player from this events teams, this is maybe a model method
    wattball_player { WattballPlayer.all.sample }
    amount { rand(3) + 1 }
  end

  factory :ticket do
    start do
      match = FactoryGirl.create(:wattball_match)
      match.event.start.to_date
    end

    user { Dummy.getRandom(User) }
    status "printed"
    adults { rand(4) + 1 }
    concessions { rand(4) }
    competition { Competition.first || FactoryGirl.create(:competition) }
  end

  factory :sport_center do
    name "Heriot Watt Sport Center"
    about "A place to get fit and keep healthy"
    email "sport-center@hw.ac.uk"
    address_line1 "Heriot-Watt University"
    address_line2 "Edinburgh Campus"
    address_city "Edinburgh"
    address_postcode "EH14 4AS"
    contact 
  end
end
