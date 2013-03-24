class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  has_many :wattball_players
  has_many :wattball_matches_as_team1, :class_name => 'WattballMatch', :foreign_key => :team1_id
  has_many :wattball_matches_as_team2, :class_name => 'WattballMatch', :foreign_key => :team2_id

  attr_accessible :badge, :badge_file_name, :teamName, :user, :user_id, :tournament_id, :org_tag, :user_attributes

  has_attached_file :badge, :styles => { :medium => "300x300>", :thumb => "100x100>"  }

  accepts_nested_attributes_for :user

  validates_presence_of :user, :teamName, :tournament, :org_tag, :phone_number
  validates_associated :tournament, :user

  validates :website, :format => { :with => /https?:\/\/[a-zA-Z\-]+?(\.[a-zA-Z\-]+)+/, :message => "Not a valid URL (Needs http://)", :allow_nil => true}
  # Check the wattball id is a H followed by 6 numbers, exactly
  validates :org_tag, :format => { :with => /^H[0-9]{6}$/, 
    :message => "ID should be a \"H\" followed by 6 numbers" }

  # Get all the matches team is playing in
  def wattball_matches
    self.wattball_matches_as_team1 + self.wattball_matches_as_team2
  end

  def played_matches
    WattballMatch.joins(:event).where("status = :status and (team1_id = :team or team2_id = :team)", :status => "played", :team => self)
  end

  # Add up all the points a team has been awarded from matches
  def total_points

    points = 0
    wattball_matches_as_team1.each do |match|
      points += match.points(1) || 0
    end

    wattball_matches_as_team2.each do |match|
      points += match.points(2) || 0
    end

    points
  end

  # Calculate the total goal difference accrued by the team
  def goal_difference
    total_diff = 0

    wattball_matches_as_team1.each do |match|
      total_diff = match.goal_difference[0]
    end

    wattball_matches_as_team2.each do |match|
      total_diff += match.goal_difference[1]
    end
       
    total_diff
  end

  # Make a list of teams and their result
  def self.rank
    teams = Team.all.sort_by { |team| -team.total_points }
  end

  # Get the matches that the current team is playing in
  def upcoming_matches
    matches = Event.upcoming.map do |ev| 
      match = ev.wattball_match

      # Get non-null matches that the team is playing in
      match if match and (match.team1 == self or match.team2 == self)
    end

    matches.compact!
  end
end
