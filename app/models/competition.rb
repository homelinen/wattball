class Competition < ActiveRecord::Base
  has_one :tournament
  attr_accessible :adult_price, :concession_price, :name, :ticket_limit
end
