require 'spec_helper'
require 'factory_girl'

describe Staff do

  before(:each) do
    @staff = FactoryGirl.build(:staff)
  end

  it { @staff.should validate_presence_of :address }
  it { @staff.should validate_presence_of :user }
  it { @staff.should validate_presence_of :telephone }
end
