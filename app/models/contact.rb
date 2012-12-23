class EmergencyContact < ActiveRecord::Base
  attr_accessible :name, :city, :country, :line1, :line2, :postcode
end
