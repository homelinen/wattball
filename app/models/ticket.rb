class Ticket < ActiveRecord::Base
  belongs_to :user
  attr_accessible :start, :status, :denomination, :user_id, :user

  validates_presence_of :user, :status, :denomination, :start

  # This needs be be tournament OR events
  validates_associated :user

  validate :valid_date

  validates :denomination, :inclusion => { :in => %w( adult concession ) }

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
