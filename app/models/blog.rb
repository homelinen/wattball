class Blog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :title, :user_id, :user
  validates_presence_of :title, :body, :user
end
