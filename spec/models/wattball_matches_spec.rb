require 'spec_helper'
require 'factory_girl'

describe WattballMatch do

  before(:each) do
    @wattball_match = FactoryGirl.build(:wattball_match)
  end

  it { @wattball_match.should have_many :scores }

  it { @wattball_match.should validate_presence_of :team1 }
  it { @wattball_match.should validate_presence_of :team2 }
  it { @wattball_match.should validate_presence_of :event }

  it { @wattball_match.should_not allow_value(@wattball_match.team1).for(:team2) }
  it { @wattball_match.should_not allow_value(@wattball_match.team2).for(:team1) }

  describe "has points" do
    before(:each) do
      team1 = FactoryGirl.create(:team)
      team2 = FactoryGirl.create(:team)
      @player1 = FactoryGirl.create(:wattball_player, :team => team1)
      @player2 = FactoryGirl.create(:wattball_player, :team => team2)

      @wattball_match = FactoryGirl.create(:wattball_match, :team1_id => team1.id, :team2_id => team2.id)
    end

    describe "results" do 
      it do
        amount = 2
        score = FactoryGirl.create(:score, 
                                    :amount => amount, 
                                    :wattball_match => @wattball_match, 
                                    :wattball_player => @player1
                                   )
        @wattball_match.result.should eq([amount, 0])
      end

      it do
        amount = 2
        score = FactoryGirl.create(:score, 
                                    :amount => amount, 
                                    :wattball_match => @wattball_match, 
                                    :wattball_player => @player2
                                   )
        @wattball_match.result.should eq([0, amount])
      end
    end

    describe "points" do

      it "for win" do 
        
        amount = 2
        score = FactoryGirl.create(:score, 
                                    :amount => amount, 
                                    :wattball_match => @wattball_match, 
                                    :wattball_player => @player1
                                   )
        @wattball_match.points(1).should eq(3)
      end

      it "for loss" do
        amount = 2
        score = FactoryGirl.create(:score, 
                                    :amount => amount, 
                                    :wattball_match => @wattball_match, 
                                    :wattball_player => @player1
                                   )

        @wattball_match.points(2).should eq(0)
      end

      before(:each) do 
        amount = 2
        FactoryGirl.create(:score,
                              :amount => amount, 
                              :wattball_match => @wattball_match, 
                              :wattball_player => @player1
                             )
        FactoryGirl.create(:score,
                              :amount => amount, 
                              :wattball_match => @wattball_match, 
                              :wattball_player => @player2
                             )
      end

      it { @wattball_match.points(1).should eq(1) }
      it { @wattball_match.points(2).should eq(1) }
    end

    describe "goal_difference" do
      def score(amount, player)
        FactoryGirl.create(:score,
                              :amount => amount, 
                              :wattball_match => @wattball_match, 
                              :wattball_player => player
                             )
      end

      it do
        amount = 2
        score(amount, @player1)

        @wattball_match.goal_difference.should eq([amount, 0])
      end

      it do
        amount = 2
        score(amount, @player2)

        @wattball_match.goal_difference.should eq([0, amount])
      end

      it do
        amount = 2
        score(amount, @player1)
        score(amount, @player2)

        @wattball_match.goal_difference.should eq([0,0])
      end

      it do
        amount = 2
        diff = 3
        score(amount + diff, @player1)
        score(amount, @player2)

        @wattball_match.goal_difference.should eq([diff, 0])
      end
    end
  end
end
