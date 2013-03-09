class HurdleTimes < ActiveRecord::Base
  belongs_to :hurdle_player
  belongs_to :hurdle_match
  attr_accessible :lane, :time
end
