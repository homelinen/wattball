class Contact < ActiveRecord::Base
  has_one :sport_center
  has_one :athlete
  attr_accessible :name, :city, :country, :line1, :line2, :postcode
end
