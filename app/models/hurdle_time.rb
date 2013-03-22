class HurdleTime < ActiveRecord::Base
  belongs_to :hurdle_player
  belongs_to :hurdle_match
  attr_accessible :lane, :time


  # Get the result of this time
  def position_result
   hurdle_match.rank.index(self) + 1
  end
end
