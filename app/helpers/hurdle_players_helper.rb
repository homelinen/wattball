module HurdlePlayersHelper

  # Print the sex column nicely
  def print_sex(sex)
    if sex == 'f'
      "Female"
    elsif sex == 'm'
      "Male"
    end
  end
end
