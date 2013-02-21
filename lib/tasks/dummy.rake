require 'factory_girl'

namespace :dummy do

  desc "Remove all models"
  task :clean => :environment do
    User.delete_all
    Team.delete_all
    Athlete.delete_all
  end

  desc "Generate a fake user"
  task :user => :environment  do
    user = FactoryGirl.create(:user)
    p user
  end

  task :team => :environment  do
    team = FactoryGirl.create_list(:team, 4)
    p team
  end

  desc "Generate 44 Players and 4 Teams"
  task :wattball_player => :team  do
    team = FactoryGirl.create_list(:wattball_player, 44)
    p team
  end

  task :tournament => :environment do
    FactoryGirl.create(:tournament)
  end

  desc "Generate 2 Wattball Matches"
  task :wattball_matches => :tournament do
    FactoryGirl.create_list(:wattball_match, 2)
  end

  task :hurdle_players => :environment do
    FactoryGirl.create_list(:hurdle_player, 8)
  end

  task :hurdle_match => :hurdle_players do
    FactoryGirl.create_list(:hurdle_match, 2)
  end

  desc "Create a Hurdle Match with Times"
  task :hurdle_matches => :hurdle_match do
    FactoryGirl.create_list(:hurdle_times, 8)
  end

  task :scores => :environment do
    p FactoryGirl.create_list(:score, 12)
  end
end
