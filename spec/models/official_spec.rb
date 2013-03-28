require 'spec_helper'
require 'factory_girl'

describe Official do

  before(:each) do
    @official = FactoryGirl.build(:official)
  end

  it { @official.should validate_presence_of :phone }
  it { @official.should validate_presence_of :user }
end
