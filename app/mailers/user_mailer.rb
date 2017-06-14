class UserMailer < ApplicationMailer

  default from: "\"Seamless\" <noreply@#{ENV['SEAMLESS__DOMAIN']}>"

  def send_invite invite
    @invite = invite
    mail({
      to: @invite.email, 
      subject: "You've been invited to a Seamless #{@invite.invitable_type}!"
    })
  end

end
