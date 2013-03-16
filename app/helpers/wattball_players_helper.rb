module WattballPlayersHelper

  # Print a table of the last 3 games a player scored in
  def recent_goals(player)

    scores = player.scores.limit(3).map do |score|
      content_tag :li, "#{score.amount} in 
        #{link_to score.wattball_match.name, score.wattball_match}".html_safe 
    end

    content_tag :ul, scores.join.html_safe
  end
end
