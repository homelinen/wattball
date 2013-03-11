class WattballMatch < ActiveRecord::Base
  belongs_to :event
  has_many :scores

  belongs_to :team1, :class_name => Team
  belongs_to :team2, :class_name => Team

  attr_accessible :team1, :team2

  validates_presence_of :team1, :team2, :event

  def self.details(lim)
    lim = nil if lim == 0
    WattballMatch.joins(:event).order(:start).limit(lim)
  end

  def name
      "#{self.team1.teamName} vs #{self.team2.teamName}"
  end

  def match_name
    "#{self.team1.teamName} vs #{self.team2.teamName}"
  end
end
