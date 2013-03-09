class Contact < ActiveRecord::Base
  has_one :sport_center
  has_one :wattball_player
  attr_accessible :name, :city, :country, :line1, :line2, :postcode

  validates_presence_of :name, :city, :line1, :postcode
end
