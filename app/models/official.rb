class Official < ActiveRecord::Base
  belongs_to :user
  attr_accessible :phone, :user_attributes 
  
  accepts_nested_attributes_for :user
end
