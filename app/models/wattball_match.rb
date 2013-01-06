class WattballMatch < ActiveRecord::Base
  belongs_to :event

  belongs_to :team1, :class_name => Team
  belongs_to :team2, :class_name => Team

  attr_accessible :team1, :team2
end
