class Event < ActiveRecord::Base
  belongs_to :official
  belongs_to :tournament
  belongs_to :venue

  has_one :wattball_match
  has_one :hurdle_match

  # NOTE: Does event need to know this?
  has_many :hurdle_times, :through => :hurdle_match

  attr_accessible :date, :end, :start, :status, :official_id, :tournament_id

  validates_presence_of :start, :status, :tournament, :venue

  validate :valid_start, :message => "Date must be in the future"

  # Find the Current Running order of an event in a tournament
  #
  # Returns: An int for the position in the event 1 - first, n - last
  def number_of_event
    tournament = Event.where(:tournament_id => self.tournament.id).order :date

    tournament.index( self ) + 1
  end

  def valid_start
    if self.start and self.start < Date.today
      errors.add(:start, "can't be in the past")
    end
  end
end
