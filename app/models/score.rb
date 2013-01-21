class Score < ActiveRecord::Base
  belongs_to :wattball_player
  belongs_to :event

  # Number of goals prevents duplicates in the table
  attr_accessible :amount

  # Calculate the score for a match
  #
  # match - An WattballMatch with two different teams
  #
  # Example
  #   Score.match_score(WattballMatch.first) 
  #   => [3, 0]
  #
  # Returns an array of scores [team1_score, team2_score]
  def self.match_score(match)
    score1 = calculate_score(match.team1, match.event) 
    score2 = calculate_score(match.team2, match.event) 

    [ score1, score2 ]
  end

  # Calculate the points scored by team at event
  #
  # team - The team playing
  # event - The event where the team played a match
  #
  # Returns the points scored by a team in the match
  def self.calculate_score(team, event)
    Score.includes(:wattball_player).includes(:event).where(:athletes => {"team_id" => team.id}, :events => { :id => event.id }).sum(:amount)
  end

end
