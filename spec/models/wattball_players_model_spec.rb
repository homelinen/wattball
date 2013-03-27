require 'spec_helper'
require 'factory_girl'

describe WattballPlayer do

  before(:each) do
    @wattball_player = FactoryGirl.build(:wattball_player)
  end

  it { @wattball_player.should validate_presence_of :user }
  it { @wattball_player.should validate_presence_of :phone_number }
  it { @wattball_player.should validate_presence_of :dob }
  it { @wattball_player.should validate_presence_of :team_id }

  # Ensure contact is optional
  it { @wattball_player.should_not validate_presence_of :contact }

end


