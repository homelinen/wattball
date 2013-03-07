require 'spec_helper'
require 'factory_girl'

describe Team do

  before(:each) do
    @team = FactoryGirl.build(:team)
  end

  it { @team.should validate_presence_of :user }
  it { @team.should validate_presence_of :teamName }
  it { @team.should validate_presence_of :tournament }

  it { @team.should have_many :wattball_matches_as_team1 }
  it { @team.should have_many :wattball_matches_as_team2}
  it { @team.should have_many :wattball_players }

end


