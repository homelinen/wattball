class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  
  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :start, :end, :adults, :concess, :type, :price
end