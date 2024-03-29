require 'faker'
require 'factory_girl'

# Some of the generators were taken from: 
# https://gist.github.com/300536
class Dummy 

  # fake a time from: time ago + 1-8770 (a year) hours after
  def self.fake_time_from(time_ago = 1.year.ago)
    time_ago+(rand(8770)).hours
  end

  # useful for prepending to a string for getting a more unique string
  def self.random_letters(length = 2)
    Array.new(length) { (rand(122-97) + 97).chr }.join
  end

  def self.random_numbers(length = 2)
    Array.new(length) { rand(10) }.join
  end

  # pick a random model from the db, done this way to avoid differences in mySQL rand() and postgres random()

  def self.pick_random(model, optional = false)

    return nil if optional && (rand(2) > 0)

    ids = ActiveRecord::Base.connection.select_all("SELECT id FROM #{model.to_s.tableize}")

    model.find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?

  end
end

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password 'sekret'
    password_confirmation 'sekret'
    admin false
    registered true
  end

  factory :staff do
    user
    address
    telephone { Faker::PhoneNumber.phone_number }
  end

  factory :contact do
    name { Faker::Name.name }
    line1 { Faker::Address.street_address }
    city { Faker::Address.city }
    country 'United Kingdom'
    postcode { Faker::Address.postcode }
  end

  factory :team do
    user
    tournament { 
      sport = Sport.where(:name => "Wattball").first || FactoryGirl.create(:sport)
      Tournament.where(:sport_id => sport.id).first || FactoryGirl.create(:tournament) }
    teamName { Faker::Name.first_name + " FC"}
    org_tag {'H' + Dummy.random_numbers(6) }
  end

  factory :official do
    user
    phone { Faker::PhoneNumber.phone_number }
  end

  factory :wattball_player do
    user
    dob { Dummy.fake_time_from((19..24).to_a.sample.year.ago) }
    phone_number { Faker::PhoneNumber.phone_number }
    contact
    # Select a random team
    team { Dummy.pick_random(Team) || FactoryGirl.create(:team) }
  end

  factory :hurdle_player do
    user
    dob { Dummy.fake_time_from((19..24).to_a.sample.year.ago) }
    nationality 'British'
    phone_number { Faker::PhoneNumber.phone_number }
    previous_time { Time.at(1.minute + rand(60).seconds) }
    sex { %w( m f ).sample }
    tournament { Tournament.last || FactoryGirl.create(:tournament) }
  end
end
