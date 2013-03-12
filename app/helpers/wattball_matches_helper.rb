module WattballMatchesHelper

  # Get a friendly string describing an event
  def wattball_match_name(wattball_match)
    %Q(
      #{wattball_match.name}
      at #{get_time_of_event(wattball_match.event.start)} 
      on #{get_date_for_event wattball_match.event.start}
    )
  end
end
