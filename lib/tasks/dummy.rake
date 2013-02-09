require 'factory_girl'

namespace :dummy do

  desc "Remove all models"
  task :clean => :environment do
    User.delete_all
    Team.delete_all
    Athlete.delete_all
    WattballMatch.delete_all
    HurdleMatch.delete_all
    Score.delete_all
  end

  desc "Generate a fake user"
  task :user => :environment  do
    user = FactoryGirl.create(:user)
    p user
  end

  task :tournament => :environment do
    FactoryGirl.create(:tournament)
  end

  task wattball_matches: [:tournament] do

    # Create 4 teams
    (1..4).each do |i|
        puts "Creating team #{i}"
        team = FactoryGirl.create(:team)
        FactoryGirl.create_list(:wattball_player, 11, team: team)
    end

    FactoryGirl.create_list(:wattball_match, 4)
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

  desc "Generate 4 Wattball Matches And 8 Scores for Matches"
  task :wattball_scores => :wattball_matches do
    p FactoryGirl.create_list(:score, 8)
  end

  desc "Create a base working data-set"
  task base: [:clean, :wattball_scores, :hurdle_players]
end
