class UserMailer < ActionMailer::Base
  default from: "hw@homelinen.org"

  def confirm_ticket(user, url)
    @user = user
    @url = url
    mail(:to => user.email, :suject => "Your Ticket Order")
  end
end
