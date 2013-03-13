class Tournament < ActiveRecord::Base
  belongs_to :sport
  belongs_to :competition

  has_many :events
  has_many :teams

  attr_accessible :endDate, :max_competitors, :name, :startDate, :sport_id
end
