class Sport < ActiveRecord::Base
  has_many :venues
  has_many :tournaments

  attr_accessible :length, :name
end
