class Manager < ActiveRecord::Base
  belongs_to :user
  attr_accessible :teamname, :user_id
end
