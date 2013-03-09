require 'spec_helper'
require 'factory_girl'

describe WattballPlayer do

  before(:each) do
    @wattball_player = FactoryGirl.build(:wattball_player)
    @valid_wattball_id = "H123456"
  end

  it { @wattball_player.should validate_presence_of :user }
  it { @wattball_player.should validate_presence_of :phone_number }
  it { @wattball_player.should validate_presence_of :dob }
  it { @wattball_player.should validate_presence_of :team }

  # Ensure contact is optional
  it { @wattball_player.should_not validate_presence_of :contact }

  it { @wattball_player.should allow_value(@valid_wattball_id).for :org_tag }

  it "should not allow one less number" do 
    @wattball_player.should_not allow_value(@valid_wattball_id.chop).for(:org_tag).with_message("ID should be a \"H\" followed by 6 numbers") 
  end

  it "should not allow one extra number" do
    @wattball_player.should_not allow_value(@valid_wattball_id + "7").for(:org_tag).with_message("ID should be a \"H\" followed by 6 numbers")
  end

  it "should always expect a h" do
    @wattball_player.should_not allow_value(@valid_wattball_id.delete("H")).for(:org_tag).with_message("ID should be a \"H\" followed by 6 numbers")

  end
end


