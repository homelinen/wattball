class Competition < ActiveRecord::Base
  has_one :tournament
  attr_accessible :adult_price, :concession_price, :name, :ticket_limit

  validates_presence_of :name, :ticket_limit

  # Check for negative currencies
  validates :adult_price, :numericality => { :greater_than_or_equal_to => 0.00 }
  validates :concession_price, :numericality => { :greater_than_or_equal_to => 0.00 }
end
