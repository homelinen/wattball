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
end
