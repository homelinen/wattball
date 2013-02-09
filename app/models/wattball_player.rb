class WattballPlayer < Athlete

  # Combine first and last names of user
  # (This should be taken for all users)
  def name
   [self.user.first_name, self.user.last_name].join " "
  end
end
