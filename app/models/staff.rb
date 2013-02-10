class Staff < ActiveRecord::Base
  belongs_to :address
  belongs_to :user

  attr_accessible :address, :user, :telephone

  validates_presence_of :address, :user, :telephone
end
