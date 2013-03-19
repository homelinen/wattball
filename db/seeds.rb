# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "factory_girl"

# Create the default Admin user
# TODO: Gather details from a config/file?
User.create({first_name: 'admin', password: 'changeme', email: 'user@example.com', admin: true}) 

FactoryGirl.create :sport_center

# Create the tournaments
FactoryGirl.create(:tournament, :name => "Wattball Tournament")

# Create 4 teams of 11 players
(1..4).each do |i|
    team = FactoryGirl.create(:team)
    FactoryGirl.create_list(:wattball_player, 11, team: team)
end

FactoryGirl.create_list(:wattball_match, 4)

FactoryGirl.create_list(:score, 8)

# Hurdle seed, 8 players, 2 rounds and 8 times
FactoryGirl.create(:tournament, :name => "Hurdle Tournament", 
                   :sport => FactoryGirl.create(
                     :sport, 
                     :name => "hurdles"
                    )
                  )


FactoryGirl.create_list(:hurdle_player, 8)
# FIXME: Replace the hurdle_match generator with the scheduler
FactoryGirl.create_list(:hurdle_match, 2)
FactoryGirl.create_list(:hurdle_time, 8)


