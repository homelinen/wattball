class Score < ActiveRecord::Base
  belongs_to :wattball_player
  belongs_to :wattball_match

  # Number of goals prevents duplicates in the table
  attr_accessible :amount, :wattball_match_id, :wattball_player_id, :wattball_player, :wattball_match

  validates_presence_of :wattball_match_id, :wattball_player_id

  validates :amount, :presence => true, :numericality => { :greater_than => 0 }

end
