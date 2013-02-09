# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create the default Admin user
# TODO: Gather details from a config/file?
User.create({first_name: 'admin', password: 'changeme', email: 'user@example.com', admin: true}) 
