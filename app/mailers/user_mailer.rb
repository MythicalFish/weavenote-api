class UserMailer < ApplicationMailer

  default from: "\"Seamless\" <noreply@#{ENV['SEAMLESS__DOMAIN']}>"

  def send_invite params
    mail(params)
  end

end
