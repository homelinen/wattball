class Event < ActiveRecord::Base
  belongs_to :official
  belongs_to :tournament

  has_one :wattball_match
  has_one :hurdle_match
  has_many :hurdle_times, :through => :hurdle_match

  attr_accessible :date, :end, :start, :status, :official_id, :tournament_id

  # Find the Current Running order of an event in a tournament
  #
  # Returns: An int for the position in the event 1 - first, n - last
  def number_of_event
    tournament = Event.where(:tournament_id => self.tournament.id).order :date

    tournament.index( self ) + 1
  end
end
