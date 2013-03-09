module HurdleMatchesHelper

  # Print a Time as 1:06s
  #
  # Useful for lengths of time, not dates
  def time_to_mins_and_secs(time)
        "#{time.min}:#{time.strftime("%S.%2N")}"
  end

  # Print athletes and their times
  def print_times(match)

    list = ""

    match.hurdle_times.each do |times|
      content = "#{link_to times.athlete.user.name, times.athlete} - "

      time = times.time

      if time.nil?
        # Could possibly get the athletes previous time
        timestring = "No time"
      else
        timestring = time_to_mins_and_secs time
      end

      content += timestring
      # Create a new li containing the tracked time
      list += content_tag(:li, content.html_safe)
    end

    content_tag(:ul, list.html_safe)
  end
end
