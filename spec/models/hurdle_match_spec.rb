require 'spec_helper'
require 'factory_girl'

describe HurdleMatch do

  before(:each) do
    @hurdle_match = FactoryGirl.build(:hurdle_match)
  end

  it { @hurdle_match.should validate_presence_of :event }
end
