require 'spec_helper'
require 'factory_girl'

describe Ticket do

  before(:each) do
    @ticket = FactoryGirl.build(:ticket)
    # Ensure other validations don't explode
    @ticket.adults = 4
    @ticket.start = 7.days.from_now
  end

  it { @ticket.should validate_presence_of :user }
  it { @ticket.should validate_presence_of :start }

  describe "@ticket numbers" do

    it do
      @ticket.adults = 0;
      @ticket.should_not allow_value(0).for(:concessions)
    end
    it do
      @ticket.concessions = 0;
      @ticket.should_not allow_value(0).for(:adults) 
    end

    it do
      @ticket.adults = (1..4).to_a.sample
      @ticket.should allow_value(0).for(:concessions)
    end
    it do
      @ticket.concessions = (1..4).to_a.sample
      @ticket.should allow_value(0).for(:adults)
    end

    it { @ticket.should_not allow_value(Date.yesterday).for(:start) }
  end

end


