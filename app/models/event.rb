class Event < ActiveRecord::Base
  belongs_to :official
  belongs_to :tournament
  belongs_to :venue

  has_one :wattball_match
  has_one :hurdle_match

  # NOTE: Does event need to know this?
  has_many :hurdle_times, :through => :hurdle_match

  attr_accessible :date, :end, :start, :status, :official_id, :tournament_id, :round, :official

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
    if start
      if self.start < DateTime.now
        errors.add(:start, 'must be in the future') 
      end
    end
  end
  
  def name
    if wattball_match
      wattball_match.name
    elsif hurdle_match
      hurdle_match.name
    end
  end

  def type
    type = WattballMatch if wattball_match
    type = HurdleMatch if hurdle_match

    type
  end

  def self.get_match_list(date)
    event = Event.on_date(date);
    if event.length > 0 
      matches = WattballMatch.where(:event_id => event) + HurdleMatch.where(:event_id => event)
    else
      []
    end
  end

  def self.upcoming
    events = Event.order(:start).where('start > ?', Date.today)
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
