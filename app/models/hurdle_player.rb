class HurdlePlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  has_many :hurdle_times

  attr_accessible :dob, :nationality, :phone_number, :previous_time, :team_id, :user, :user_attributes, :sex, :tournament
  # :tournament_id attribute added through migration.

  validates_inclusion_of :sex, :in => %w( m f )

  #validates_associated :user
  validates_presence_of :user, :dob, :nationality, :phone_number, :tournament

  validate :valid_dob

  accepts_nested_attributes_for :user

  def valid_dob
    if dob
      if dob > 18.years.ago.to_date
        errors.add(:dob, "You must be 18 to enter this event.")
      end
    else
      errors.add(:dob, "cannot be nil")
    end
  end

  def nice_time
    Time.at(previous_time).utc.strftime('%-M:%Ss')
  end
end
