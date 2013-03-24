module EventsHelper

  # Return a well formatted string, describing the start of an event
  #
  # Example:
  #   get_time_of_event(Time.now)
  #   3:05 pm
  def get_time_of_event(time)
      time.strftime('%l:%M %P')
  end

  # Return the date in an appealing format
  #
  # Example:
  #   get_date_for_event(Time.now)
  #   Sun, 21/03/09
  def get_date_for_event(date)
    date.strftime("%A, %d/%m/%y")
  end

  # Format a datetime prettily
  def get_date_and_time(datetime)

    %W(#{get_time_of_event(datetime)} #{get_date_for_event(datetime)}).join " on "
  end

  def list_events_for_day(date)
    events = Event.get_match_list(d).map do |e|
      content_tag :li, link_to(e.name, e)
    end

    content_tag :ul, events.join.html_safe
  end

  def event_info(event)

    if event.wattball_match
      link = link_to event.name, event.wattball_match
    elsif event.hurdle_match
      link = link_to event.name, event.hurdle_match
    end

    if link
      "#{link.html_safe} at #{get_date_and_time(event.start)}"
    end
  end
end
