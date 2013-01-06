class Team < ActiveRecord::Base
  belongs_to :User
  has_many :WattballPlayer
  has_many :wattball_matches

  attr_accessible :badge, :badge_file_name, :teamName, :User, :User_id
  has_attached_file :badge, :styles => { :medium => "300x300>", :thumb => "100x100>"  }

  accepts_nested_attributes_for :User
end
