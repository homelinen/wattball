class Athlete < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  belongs_to :manager
  
  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dateOfBirth, :nationality, :organisationTag, :phoneNumber, :previousTime, :type
end
