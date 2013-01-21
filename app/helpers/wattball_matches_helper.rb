module WattballMatchesHelper

  # Get a friendly string describing an event
  def wattball_match_name(wattball_match)
    %Q(
      #{wattball_match.team1.teamName} vs #{wattball_match.team2.teamName}
      at #{get_time_of_event(wattball_match.event.start)} 
      on #{get_date_for_event wattball_match.event.date}
    )
  end
end
