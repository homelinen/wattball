class Score < ActiveRecord::Base
  belongs_to :wattball_player
  belongs_to :wattball_match

  # Number of goals prevents duplicates in the table
  attr_accessible :amount, :wattball_match_id, :wattball_player_id, :wattball_player, :wattball_match

  validates_presence_of :wattball_match_id, :wattball_player_id

  validates :amount, :presence => true, :numericality => { :greater_than => 0 }


  # Update the status of an event to be played.
  #
  # If a score exists, then the match must have been played
  def update_event_status
    event = wattball_match.event

    if event.status != "played"
      # If adding scores, then the match can be assumed to have been played
      event.status = "played"
      event.save
    end
  end
end
