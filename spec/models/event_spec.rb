require 'spec_helper'
require 'factory_girl'

describe Event do

  before(:each) do
    @event = FactoryGirl.build(:event)
  end

  it { @event.should validate_presence_of :start }


  it { @event.should_not allow_value(DateTime.now - 1.hour, :with_message => "Date must be in the future").for(:start) }
  it { should allow_value(DateTime.now + 1.hour).for(:start) }

  it { @event.should validate_presence_of :status }
  it { @event.should_not validate_presence_of :official }
  it { @event.should validate_presence_of :tournament }
  it { @event.should validate_presence_of :venue }

  it { should have_one :hurdle_match }
  it { should have_one :wattball_match }
end
