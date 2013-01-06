class WattballMatch < ActiveRecord::Base
  belongs_to :event
  has_many :playing_teams

  belongs_to :team1, :class_name => :team
  belongs_to :team2, :class_name => :team

  attr_accessible :team1, :team2
end
