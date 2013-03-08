class Score < ActiveRecord::Base
  belongs_to :wattball_player
  belongs_to :wattball_match

  # Number of goals prevents duplicates in the table
  attr_accessible :amount, :wattball_match, :wattball_player

  validates_presence_of :wattball_match, :wattball_player

  validate :amount, :presence => true, :numericality => { :greater_than => 0 }

  # Calculate the score for a match
  #
  # match - An WattballMatch with two different teams
  #
  # FIXME: Should this be static?
  #
  # Example
  #   Score.match_score(WattballMatch.first) 
  #   => [3, 0]
  #
  # Returns an array of scores [team1_score, team2_score]
  def self.match_score(match)
    score1 = calculate_score(match.team1, match) 
    score2 = calculate_score(match.team2, match) 

    [ score1, score2 ]
  end

  # Calculate the points scored by team at event
  #
  # team - The team playing
  # event - The event where the team played a match
  #
  # Returns the points scored by a team in the match
  def self.calculate_score(team, match)
     match.scores.includes(:wattball_player).where(:wattball_players => {:team_id => team}).sum(:amount) 
  end

end
