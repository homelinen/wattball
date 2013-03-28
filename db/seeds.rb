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

p "Created the admin user."

FactoryGirl.create :sport_center

FactoryGirl.create :sport, :name => "wattball", :length => 90
FactoryGirl.create :venue, :sport => Sport.last, :name => "Wattball Stadium"

FactoryGirl.create :sport, :name => "hurdles", :length => 20
FactoryGirl.create :venue, :sport => Sport.last, :name => "Hurdle Stadium"
