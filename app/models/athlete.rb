class Athlete < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  belongs_to :emergencyContact
  belongs_to :manager
  
  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dateOfBirth, :nationality, :organisationTag, :phoneNumber, :previousTime, :type
end
