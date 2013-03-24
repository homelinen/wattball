class Tournament < ActiveRecord::Base
  belongs_to :sport
  belongs_to :competition

  has_many :events
  has_many :teams
  has_many :hurdle_players

  attr_accessible :endDate, :max_competitors, :name, :startDate, :sport_id, :competition_id

  validates_presence_of :name, :startDate, :endDate, :max_competitors

  validates :max_competitors, :numericality => { :greater_than => 0 }

  def competitors 
    
    count = teams.count unless teams.empty?
    count = hurdle_players.count unless hurdle_players.empty?

    count
  end
end
