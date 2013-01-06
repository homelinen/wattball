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
    user = FactoryGirl.create_list(:user, 3)
    p user
  end

  task :team => :environment  do
    team = FactoryGirl.create_list(:team, 4)
    p team
  end

  task :wattball_player => :team  do
    team = FactoryGirl.create_list(:wattball_player, 44)
    p team
  end
end
