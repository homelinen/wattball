class Address < ActiveRecord::Base
  has_one :staff

  attr_accessible :city, :line1, :line2, :postcode, :country

  validates_presence_of :line1, :city, :postcode, :country
end
