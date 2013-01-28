class Venue < ActiveRecord::Base
  belongs_to :sport
  belongs_to :sport_center

  has_many :events

  attr_accessible :capacity, :name, :sport_id, :sport_center_id
end
