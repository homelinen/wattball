class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  attr_accessible :adults_number, :concess_number, :dsc, :end, :start, :tournament, :tournament_id, :user_id, :user

  validates_presence_of :user, :dsc, :start

  # This needs be be tournament OR events
  validates_associated :user, :tournament

  validate :valid_amount
  validate :valid_date

  def ticket_count
    self.adults_number + self.concess_number
  end

  # Ensure at least one ticket has been purchased
  def valid_amount 
    if self.adults_number < 1 && self.concess_number < 1
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
