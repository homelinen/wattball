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
end
