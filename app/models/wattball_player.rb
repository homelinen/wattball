class WattballPlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  belongs_to :team

  has_many :scores
  
  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dob, :phone_number, :team_id, :team, :user, :contact, :user_attributes, :contact_attributes

  accepts_nested_attributes_for :user, :contact, :team

  validates_associated :user, :contact
  validates_presence_of :user, :dob, :team_id, :phone_number
end
