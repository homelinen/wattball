require 'spec_helper'
require 'factory_girl'

describe Contact do

  before(:each) do
    @contact = FactoryGirl.build(:contact)
  end

  it { @contact.should validate_presence_of :name }
  it { @contact.should validate_presence_of :line1 }
  it { @contact.should validate_presence_of :city }
  it { @contact.should validate_presence_of :postcode }

end
