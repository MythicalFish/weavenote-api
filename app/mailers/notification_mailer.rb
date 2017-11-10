class NotificationMailer < ApplicationMailer

  default from: "\"Weavenote\" <noreply@#{ENV['WEAVENOTE__DOMAIN']}>"

  def send_notification notification
    @notification = notification
    mail({
      to: notification.receiver.email, 
      subject: email_title,
      template_name: notification.type
    })
  end

  private

  def email_title
    case @notification.type
      when 'mention'
        return "#{@notification.creator.name} mentioned you"
      else
        return "Undefined notification"
    end
  end

end
