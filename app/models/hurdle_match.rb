class HurdleMatch < ActiveRecord::Base
  belongs_to :event
  has_many :hurdle_times

  accepts_nested_attributes_for :event 

  # Fetch all the times for the current match
  def hurdle_times
    HurdleTimes.where(:hurdle_match_id => id)
  end
end
