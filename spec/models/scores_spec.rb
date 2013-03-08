require 'spec_helper'
require 'factory_girl'

describe Score do

  before(:each) do
    @scores = FactoryGirl.build(:score)
  end

  it { @scores.should validate_presence_of :amount }
  it { @scores.should validate_presence_of :wattball_player_id }
  it { @scores.should validate_presence_of :wattball_match_id }

  it { @scores.should_not allow_value(0).for(:amount) }
end
