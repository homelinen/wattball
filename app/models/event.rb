class Event < ActiveRecord::Base
  belongs_to :official
  belongs_to :tournament

  has_one :wattball_match

  attr_accessible :date, :end, :start, :status, :official_id, :tournament_id
end
