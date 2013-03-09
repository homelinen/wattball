require 'spec_helper'
require 'factory_girl'

describe HurdlePlayer do
  before(:each) do
    @hurdle_player = FactoryGirl.build(:hurdle_player)
  end

  it { @hurdle_player.should validate_presence_of :user }
  it { @hurdle_player.should validate_presence_of :phone_number }
  it { @hurdle_player.should validate_presence_of :dob }
  it { @hurdle_player.should validate_presence_of :nationality }

  it { @hurdle_player.should ensure_inclusion_of(:sex).in_array %w( m f ) }
end
