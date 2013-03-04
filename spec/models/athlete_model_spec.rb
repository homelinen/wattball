require 'spec_helper'
require 'factory_girl'

describe Athlete do

  describe "wattball_player" do
    before(:each) do
      @wattball_player = FactoryGirl.build(:wattball_player)
      @valid_wattball_id = "H123456"
    end

    it { @wattball_player.should validate_presence_of :user }
    it { @wattball_player.should validate_presence_of :phoneNumber }
    it { @wattball_player.should validate_presence_of :nationality }

    it { @wattball_player.should ensure_inclusion_of(:sex).in_array %w( m f ) }

    it { @wattball_player.should allow_value(@valid_wattball_id).for :organisationTag }

    it "should not allow one less number" do 
      @wattball_player.should_not allow_value(@valid_wattball_id.chop).for(:organisationTag).with_message("ID should be a \"H\" followed by 6 numbers") 
    end

    it "should not allow one extra number" do
      @wattball_player.should allow_value(@valid_wattball_id + "7").for(:organisationTag).with_message("ID should be a \"H\" followed by 6 numbers")
    end

    it "should always expect a h" do
      @wattball_player.should allow_value(@valid_wattball_id.delete("H")).for(:organisationTag).with_message("ID should be a \"H\" followed by 6 numbers")
 
    end
  end

end


