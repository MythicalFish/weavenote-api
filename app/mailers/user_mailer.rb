class UserMailer < ApplicationMailer

  default from: "\"WeaveNote\" <noreply@#{ENV['WEAVENOTE__DOMAIN']}>"

  def send_invite invite
    @invite = invite
    mail({
      to: @invite.email, 
      subject: "You've been invited to a WeaveNote #{@invite.invitable_type}!"
    })
  end

end
