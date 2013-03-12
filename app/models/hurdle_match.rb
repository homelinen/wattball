class HurdleMatch < ActiveRecord::Base
  belongs_to :event
  has_many :hurdle_times

  accepts_nested_attributes_for :event 

  validates_presence_of :event

  def name
    "Heat: #{self.event.number_of_event}"
  end
end
