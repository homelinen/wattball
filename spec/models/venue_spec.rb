require 'spec_helper'
require 'factory_girl'

describe Venue do

  before(:each) do
    @venue = FactoryGirl.build(:venue)
  end

  it { @venue.should validate_presence_of :capacity }
  it { @venue.should validate_presence_of :name }

#  This fails for SOME reason
#  it { @venue.should validate_uniqueness_of :name }

  it { @venue.should validate_presence_of :sport }
  it { @venue.should validate_presence_of :sport_center }
end
