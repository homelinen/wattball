require 'spec_helper'
require 'factory_girl'

describe WattballMatch do

  before(:each) do
    @wattball_match = FactoryGirl.build(:wattball_match)
  end

  it { @wattball_match.should have_many :scores }

  it { @wattball_match.should validate_presence_of :team1 }
  it { @wattball_match.should validate_presence_of :team2 }
  it { @wattball_match.should validate_presence_of :event }

  it { @wattball_match.should_not allow_value(@wattball_match.team1).for(:team2) }
  it { @wattball_match.should_not allow_value(@wattball_match.team2).for(:team1) }
end
