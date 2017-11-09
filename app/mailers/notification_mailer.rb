class NotificationMailer < ApplicationMailer

  default from: "\"Weavenote\" <noreply@#{ENV['WEAVENOTE__DOMAIN']}>"

  def send_notification notification
    mail({
      to: notification.receiver.email, 
      subject: notification.title
    })
  end

end
