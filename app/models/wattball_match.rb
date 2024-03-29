class WattballMatch < ActiveRecord::Base
  belongs_to :event
  has_many :scores

  belongs_to :team1, :class_name => Team
  belongs_to :team2, :class_name => Team

  attr_accessible :team1, :team2, :event_attributes

  accepts_nested_attributes_for :event

  validates_presence_of :team1, :team2, :event

  validate :validate_different_teams

  def self.most_recent(lim)
    lim = 0 if lim == nil
    WattballMatch.joins(:event).order(:start).limit(lim)
  end

  def name
      "#{self.team1.teamName} vs #{self.team2.teamName}"
  end

  def validate_different_teams
    if team1 and team2
      if team1 == team2
        errors.add(:team1, "not allowed to be the same as team2")
        errors.add(:team2, "not allowed to be the same as team2")
      end
    end
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

  def teams
    [ team1, team2 ]
  end

  # Get an array of players for a match
  def players
    # Build two arrays of players
    cur_players = teams.map do |team|
      team.wattball_players
    end

    # Combine the arrays
    cur_players.flatten! 
  end

  # Get the points for the match as team 1 or team 2
  #
  # team - Team number: 1 or 2
  def points(team)
    first = 0
    res = self.result

    if res
      if team == 1
        first_team = res[0]
        sec_team = res[1]
      elsif team == 2
        first_team = res[1]
        sec_team = res[0]
      else 
        raise "Invalid Team chosen"
      end

      p first_team <=> sec_team
      # Compare the results
      outcome = first_team <=> sec_team

      if outcome > 0
        # Win
        result = 3
      elsif outcome < 0
        # Loss
        result = 0
      else 
        # Draw
        result = 1
      end
    else
      result = nil
    end

    result
  end


  # Calculate the difference between goals of the two teams
  #
  # Returns an array of differences, [team1, team2]
  def goal_difference
    p1 = calculate_score(team1)
    p2 = calculate_score(team2)

    return 0 if p1.nil? or p2.nil?

     diff = p1 - p2

     diff_1 = diff
     diff_1 = 0 if diff_1 < 0

     # The goal difference for second team is the inverse
     diff_2 = -diff
     diff_2 = 0 if diff_2 < 0

     [diff_1, diff_2]
  end
end
