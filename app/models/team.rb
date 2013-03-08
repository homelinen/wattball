class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  has_many :wattball_player
  has_many :wattball_matches

  attr_accessible :badge, :badge_file_name, :teamName, :user, :user_id, :tournament_id
  has_attached_file :badge, :styles => { :medium => "300x300>", :thumb => "100x100>"  }

  accepts_nested_attributes_for :user

  validates_associated :tournament
end
