class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition

  attr_accessible :start, :status, :competition, :competition_id, :user_id, :user, :adults, :concessions

  validates_presence_of :user, :status, :competition, :start, :adults, :concessions

  # This needs be be tournament OR events
  validates_associated :user

  validate :valid_date
  validates :adults, :numericality => { :greater_than_or_equal_to => 0 }
  validates :concessions, :numericality => { :greater_than_or_equal_to => 0 }

  validate :valid_not_sold_out
  validate :valid_amount

  # Sum the totals
  def ticket_count
    adults + concessions
  end

  def adult_price
    adults * competition.adult_price
  end

  def concession_price
    concessions * competition.adult_price
  end

  def total_price
    adult_price + concession_price
  end

  # Ensure at least one ticket has been purchased
  def valid_amount 
    if adults < 1 && concessions < 1
      errors.add(:adults, "must buy at least one adult or concession ticket")
      errors.add(:concessions, "must buy at least one concession or adult ticket")
    end
  end

  # Consider modularising this
  def valid_date
    if self.start && self.start < Date.today
      errors.add(:start, "event must be in the future")
    end
  end

  def barcode
    (self.hash + user.hash + start.hash).abs
  end

  # Check that the tickets bought don't go over the daily ticket limit
  def valid_not_sold_out
    
    ticket_count = Ticket.total_tickets competition_id
    if ticket_count + adults + concessions > competition.ticket_limit
      errors.add(:sold_out, "All tickets are sold out, sorry.")
    end
  end

  def self.total_tickets(competition_id)
    Ticket.where(:competition_id => competition_id).sum("adults") + Ticket.where(:competition_id => competition_id).sum("concessions")
  end
end
