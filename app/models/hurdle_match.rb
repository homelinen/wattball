class HurdleMatch < ActiveRecord::Base
  belongs_to :event
  has_many :hurdle_times
  has_many :hurdle_players, :through => :hurdle_times

  attr_accessible :event_attributes
  accepts_nested_attributes_for :event 

  validates_presence_of :event

  def name
    "Heat: #{self.event.number_of_event}"
  end

  # Rank the times for the event
  def rank
    hurdle_times.order(:time)
  end
end
