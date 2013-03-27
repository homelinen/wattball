require 'spec_helper'
require 'factory_girl'

describe Team do

  before(:each) do
    @team = FactoryGirl.build(:team)
    @valid_wattball_id = "H123456"
  end

  it { @team.should validate_presence_of :user }
  it { @team.should validate_presence_of :teamName }
  it { @team.should validate_presence_of :tournament }

  it { @team.should have_many :wattball_matches_as_team1 }
  it { @team.should have_many :wattball_matches_as_team2}
  it { @team.should have_many :wattball_players }

  it { @team.should allow_value(@valid_wattball_id).for :org_tag }

  it "should not allow one less number" do 
    @team.should_not allow_value(@valid_wattball_id.chop).for(:org_tag).with_message("ID should be a \"H\" followed by 6 numbers") 
  end

  it "should not allow one extra number" do
    @team.should_not allow_value(@valid_wattball_id + "7").for(:org_tag).with_message("ID should be a \"H\" followed by 6 numbers")
  end

  it "should always expect a h" do
    @team.should_not allow_value(@valid_wattball_id.delete("H")).for(:org_tag).with_message("ID should be a \"H\" followed by 6 numbers")

  end
end


