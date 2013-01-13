module HurdleMatchesHelper

  # Print a Time as 1:06s
  #
  # Useful for lengths of time, not dates
  def time_to_mins_and_secs(time)
        "#{time.min}:#{time.strftime("%S")}s"
  end

  # Print athletes and their times
  def print_times(match)
    outlist="<ul>"

    match.hurdle_times.each do |times|
      outlist += "\n<li>#{link_to join_user_name(times.athlete.user), times.athlete} - "
      time = times.time
      if time.nil?
        # Could possibly get the athletes previous time
        timestring = "No time"
      else
        timestring = time_to_mins_and_secs time
      end
      outlist += timestring
    end

    outlist += "\n</ul>"
    outlist.html_safe
  end
end
