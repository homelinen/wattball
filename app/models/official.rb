class Official < ActiveRecord::Base
  belongs_to :user
  has_many :events

  attr_accessible :phone, :user_attributes 
  
  accepts_nested_attributes_for :user

  validates_presence_of :phone, :user
end
