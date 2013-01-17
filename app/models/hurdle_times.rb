class HurdleTimes < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :hurdle_match
  attr_accessible :lane, :time
end
