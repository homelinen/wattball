class UserMailer < ActionMailer::Base
  default from: "hw-sports@homelinen.org"

  def confirm_ticket(ticket)
    @ticket = ticket
    mail(:to => ticket.user.email, :subject => "Your Ticket Order")
  end
end
