class HurdleTime < ActiveRecord::Base
  belongs_to :hurdle_player
  belongs_to :hurdle_match

  attr_accessible :time, :lane
  attr_accessible :hurdle_player_id, :hurdle_match_id

  # Get the result of this time
  def position_result
   hurdle_match.rank.index(self) + 1
  end

  # TODO: Make this a helper
  def nice_time
    Time.at(time).utc.strftime('%-M:%Ss')
  end
end
