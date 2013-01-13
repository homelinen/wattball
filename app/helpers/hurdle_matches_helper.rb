module HurdleMatchesHelper

  # Print athletes and their times
  def print_times(match)
    outlist="<ul>"

    match.hurdle_times.each do |times|
      outlist += "\n<li>#{link_to join_user_name(times.athlete.user), times.athlete} - "
      time = times.time
      if time.nil?
        timestring = "0:00"
      else
        timestring = "#{time.min}:#{time.strftime("%S")}s"
      end
      outlist += timestring
    end

    outlist += "\n</ul>"
    outlist.html_safe
  end
end
