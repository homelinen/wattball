class HurdlePlayer < ActiveRecord::Base
  belongs_to :user

  has_many :hurdle_times

  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dateOfBirth, :nationality, :phoneNumber, :previousTime, :team_id, :user, :contact, :user_attributes, :sex

  validates_inclusion_of :sex, :in => %w( m f )

  accepts_nested_attributes_for :user
end
