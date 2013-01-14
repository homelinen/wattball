class SportCenter < ActiveRecord::Base
  belongs_to :contact

  # Possibly should have many contacts
  # Also what if buildings have multiple addresses
  attr_accessible :address_city, :address_line1, :address_line2, :address_postcode, :address_town, :email, :name, :contact

  accepts_nested_attributes_for :contact
end
