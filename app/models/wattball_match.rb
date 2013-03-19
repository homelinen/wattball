class WattballMatch < ActiveRecord::Base
  belongs_to :event
  has_many :scores

  belongs_to :team1, :class_name => Team
  belongs_to :team2, :class_name => Team

  attr_accessible :team1, :team2

  validates_presence_of :team1, :team2, :event

  def self.most_recent(lim)
    lim = 0 if lim == nil
    WattballMatch.joins(:event).where(:events => {:status => 'played'}).order(:start).limit(lim)
  end

  def name
      "#{self.team1.teamName} vs #{self.team2.teamName}"
  end

  def match_name
    "#{self.team1.teamName} vs #{self.team2.teamName}"
  end

  # Calculate the Result of a Wattball Match
  #
  # Example
  #   match.result 
  #   => [3, 0]
  #
  # Returns an array of scores [team1_score, team2_score] or nil if the 
  #   match has not yet been played
  def result
    if event.status == 'played'
      score1 = calculate_score(team1) 
      score2 = calculate_score(team2) 

      [ score1, score2 ]
    else
      nil
    end
  end

  # Calculate the points scored by team at event
  #
  # team - The team playing
  #
  # Returns the points scored by a team in the match
  def calculate_score(team)
     scores.includes(:wattball_player).where(:wattball_players => {:team_id => team}).sum(:amount) 
  end
end
