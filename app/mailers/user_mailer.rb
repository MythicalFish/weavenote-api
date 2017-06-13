class UserMailer < ApplicationMailer

  default from: "noreply@#{ENV['SEAMLESS__DOMAIN']}"

  def send_invite
    mail(to: 'jakey.bt@gmail.com', subject: 'test')
  end

end
