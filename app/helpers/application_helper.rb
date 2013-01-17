module ApplicationHelper

  # Apparently bad practice to have this here, but whatever
  def join_user_name(user)
    concatName =  [user.first_name, user.last_name].join(" ") unless user.nil?
  end
end
