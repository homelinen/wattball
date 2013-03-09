class Official < ActiveRecord::Base
  belongs_to :user
  has_many :event

  attr_accessible :phone, :user_attributes 
  
  accepts_nested_attributes_for :user

  validates_presence_of :phone, :user
end
