class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  has_many :wattball_players
  has_many :wattball_matches_as_team1, :class_name => 'WattballMatch', :foreign_key => :team1_id
  has_many :wattball_matches_as_team2, :class_name => 'WattballMatch', :foreign_key => :team2_id

  attr_accessible :badge, :badge_file_name, :teamName, :user, :user_id, :tournament_id, :org_tag, :user_attributes

  has_attached_file :badge, :styles => { :medium => "300x300>", :thumb => "100x100>"  }

  accepts_nested_attributes_for :user

  validates_presence_of :user, :teamName, :tournament, :org_tag
  validates_associated :tournament, :user

  # Check the wattball id is a H followed by 6 numbers, exactly
  validates :org_tag, :format => { :with => /^H[0-9]{6}$/, 
    :message => "ID should be a \"H\" followed by 6 numbers" }

  # Get all the matches team is playing in
  def wattball_matches
    self.wattball_matches_as_team1 + self.wattball_matches_as_team2
  end

  def total_points

    points = 0
    wattball_matches_as_team1.each do |match|
      points += match.points(1)
    end

    wattball_matches_as_team2.each do |match|
      points += match.points(2)
    end

    points
  end

  # Make a list of teams and their result
  def self.rank
    teams = Team.all.sort_by { |team| team.total_points }
    teams.reverse.values_at 0..2
  end
end
