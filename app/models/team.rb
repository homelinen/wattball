class Team < ActiveRecord::Base
  belongs_to :User
  attr_accessible :badge, :teamName, :User_id
  has_attached_file :badge, :styles => { :medium => "300x300>", :thumb => "100x100>"  }
end
