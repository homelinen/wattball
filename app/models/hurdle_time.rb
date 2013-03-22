class HurdleTime < ActiveRecord::Base
  belongs_to :hurdle_player
  belongs_to :hurdle_match

  attr_accessible :lane, :time
  attr_accessible :hurdle_player_id, :hurdle_match_id

  # Get the result of this time
  def position_result
   hurdle_match.rank.index(self) + 1
  end

  def nice_time
    Time.at(time).utc.strftime('%-M:%Ss')
  end
end
