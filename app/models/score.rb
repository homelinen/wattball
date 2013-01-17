class Score < ActiveRecord::Base
  belongs_to :wattball_player
  belongs_to :event

  # Number of goals prevents duplicates in the table
  attr_accessible :amount
end
