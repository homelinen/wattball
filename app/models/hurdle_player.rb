class HurdlePlayer < ActiveRecord::Base
  belongs_to :user

  has_many :hurdle_times

  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dob, :nationality, :phone_number, :previous_time, :team_id, :user, :user_attributes, :sex

  validates_inclusion_of :sex, :in => %w( m f )

  validates_associated :user
  validates_presence_of :user, :dob, :nationality, :phone_number

  accepts_nested_attributes_for :user
end
