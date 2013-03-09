class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  has_many :wattball_players
  has_many :wattball_matches_as_team1, :class_name => 'WattballMatch', :foreign_key => :team1_id
  has_many :wattball_matches_as_team2, :class_name => 'WattballMatch', :foreign_key => :team2_id

  attr_accessible :badge, :badge_file_name, :teamName, :user, :user_id, :tournament_id
  has_attached_file :badge, :styles => { :medium => "300x300>", :thumb => "100x100>"  }

  accepts_nested_attributes_for :user

  validates_presence_of :user, :teamName, :tournament
  validates_associated :tournament, :user

  # Get all the matches team is playing in
  def wattball_matches
    self.wattball_matches_as_team1 + self.wattball_matches_as_team2
  end
end
