require 'spec_helper'
require 'factory_girl'

describe Ticket do

  before(:each) do
    @ticket = FactoryGirl.build(:ticket)
    # Ensure other validations don't explode
    @ticket.adults_number = 4
    @ticket.start = 7.days.from_now
  end

  it { @ticket.should validate_presence_of :user }
  it { @ticket.should validate_presence_of :start }
  it { @ticket.should allow_value(FactoryGirl.build(:tournament)).for(:tournament) }

  describe "@ticket numbers" do

    it do
      @ticket.adults_number = 0;
      @ticket.should_not allow_value(0).for(:concess_number).with_message(/must buy at least one ticket/)
    end
    it do
      @ticket.concess_number = 0;
      @ticket.should_not allow_value(0).for(:adults_number).with_message(/must buy at least one ticket/) 
    end

    it do
      @ticket.adults_number = (1..4).to_a.sample
      @ticket.should allow_value(0).for(:concess_number)
    end
    it do
      @ticket.concess_number = (1..4).to_a.sample
      @ticket.should allow_value(0).for(:adults_number)
    end
  end

end


