class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition

  attr_accessible :start, :status, :competition, :competition_id, :user_id, :user, :adults, :concessions

  validates_presence_of :user, :status, :competition, :start, :adults, :concessions

  # This needs be be tournament OR events
  validates_associated :user

  validate :valid_date

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
      errors.add(:ticket_count, "must buy at least one ticket")
    end
  end

  # Consider modularising this
  def valid_date
    if self.start && self.start < Date.today
      errors.add(:start, "event must be in the future")
    end
  end
end
