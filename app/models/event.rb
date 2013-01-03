class Event < ActiveRecord::Base
  belongs_to :official
  belongs_to :tournament

  attr_accessible :date, :end, :start, :status, :official_id, :tournament_id
end
