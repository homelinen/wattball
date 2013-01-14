class Venue < ActiveRecord::Base
  belongs_to :sport
  belongs_to :sport_center
  attr_accessible :capacity, :name, :sport_id, :sport_center_id
end
