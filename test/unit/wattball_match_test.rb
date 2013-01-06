require 'test_helper'
require 'factory_girl'

class WattballMatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "Succesfully Generate a Wattball Match" do

    # Hacky way to ensure a tournament is present
    if Tournament.first.nil?
      FactoryGirl.create(:tournament)
    end

    # Generate 2 new teams
    FactoryGirl.create_list(:team, 2)

    @match = FactoryGirl.build(:wattball_match)
    assert_not_nil(Team.find(@match.team1), "Has a tean")
    assert_not_nil(Team.find(@match.team2), "Has a second team")

    assert(@match.save!)
  end

end
