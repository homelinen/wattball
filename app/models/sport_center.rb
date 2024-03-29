class SportCenter < ActiveRecord::Base
  belongs_to :contact
  has_many :venue

  # Possibly should have many contacts
  # Also what if buildings have multiple addresses
  attr_accessible :address_city, :address_line1, :address_line2, :address_postcode, :address_town, :email, :name, :contact_attributes, :about

  validates_presence_of :name, :about, :email, :address_line1, :address_postcode

  accepts_nested_attributes_for :contact
end
