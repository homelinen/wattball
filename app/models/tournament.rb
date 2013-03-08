class Tournament < ActiveRecord::Base
  belongs_to :sport

  has_many :events
  has_many :teams

  attr_accessible :adult_ticket_price, :concession_ticket_price, :endDate, :max_competitors, :name, :startDate, :sport_id
end
