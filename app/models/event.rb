class Event < ActiveRecord::Base
  belongs_to :official
  belongs_to :tournament
  belongs_to :venue

  has_one :wattball_match
  has_one :hurdle_match

  # NOTE: Does event need to know this?
  has_many :hurdle_times, :through => :hurdle_match

  attr_accessible :date, :end, :start, :status, :official_id, :tournament_id, :round

  validates_presence_of :start, :status, :tournament, :venue

  validate :valid_start, :message => "Date must be in the future"

  # Find the Current Running order of an event in a tournament
  #
  # Returns: An int for the position in the event 1 - first, n - last
  def number_of_event
    tournament = Event.where(:tournament_id => self.tournament.id).order :start

    tournament.index( self ) + 1
  end

  def valid_start
    if start.is_a?(DateTime)
		errors.add(:start, 'must be in the future') if self.start < DateTime.now
    else
		#errors.add(:start, 'must be a valid date')
    end
  end

  def self.get_match_list(date)
    event = Event.on_date(date);
    if event.length > 0 
      matches = WattballMatch.where(:event_id => event) + HurdleMatch.where(:event_id => event)
    else
      []
    end
  end

  # Get ids for events on given date
  def self.on_date(date)
    ids = []
    Event.select([:id, :start]).each do |e| 
      if e.start.to_date == date 
        ids.push e.id
      end
    end

    ids
  end

  def self.next_event
    Event.where('start > ?', Date.today).first
  end
end
