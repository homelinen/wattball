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

  describe "total goal diff" do

    before(:each) do

      @team1 = FactoryGirl.create(:team)
      team2 = FactoryGirl.create(:team)

      @player1 = FactoryGirl.create(:wattball_player, :team => @team1)
      @player2 = FactoryGirl.create(:wattball_player, :team => team2)

      @wattball_match = FactoryGirl.create(
        :wattball_match, 
        :team1 => @team1, 
        :team2 => team2
      )
    end

    def score(amount, match, player)
      FactoryGirl.create(:score,
                            :amount => amount, 
                            :wattball_match => match, 
                            :wattball_player => player
                           )
    end

    it "should have a total goal difference" do

      score(4, @wattball_match, @player1)
      score(2, @wattball_match, @player2)

      @team1.goal_difference.should eq(2)
    end


    it "more complicated goal difference" do
      
      scores_against = [0, 4, 2]
      scores_concede = [3, 2, 0]

      score(scores_concede[0], @wattball_match, @player2)

      match = FactoryGirl.create(:wattball_match, :team1 => @team1, :team2 =>
                       FactoryGirl.create(:team)
                       )

      score(scores_against[1], match, @player1)
      score(scores_concede[1], match, FactoryGirl.create(:wattball_player, :team => Team.last))

      score(scores_against[2], 
            FactoryGirl.create(:wattball_match, :team1 => 
                       FactoryGirl.create(:team), :team2 => @team1),
                       FactoryGirl.create(:wattball_player, :team => Team.first))

      expected = 0
      scores_against.size.times do |i|
        if scores_against[i] > scores_concede[i]
          expected += scores_against[i] - scores_concede[i]
        end
      end

      @team1.goal_difference.should eq(expected)
    end
  end
end


