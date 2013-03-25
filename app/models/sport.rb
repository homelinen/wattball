class Sport < ActiveRecord::Base
  has_many :venues
  has_many :tournaments

  attr_accessible :length, :name

  def nice_name
    name.strip.downcase
  end
end
