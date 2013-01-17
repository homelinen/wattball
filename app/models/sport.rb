class Sport < ActiveRecord::Base
  has_many :venue

  attr_accessible :length, :name
end
