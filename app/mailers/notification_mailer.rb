class NotificationMailer < ApplicationMailer

  def send_notification notification
    @notification = notification 
    @concern = notification.concern
    # Build mail params
    mail_params = {
      to: notification.receiver.email, 
      subject: email_title,
      template_name: notification.type
    }
    mail_params[:from] = from_address if from_address
    # Sent it
    mail(mail_params)
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

  def from_address
    if @concern.class.name == 'Comment'
      e = "comment-#{@concern.key}@#{ENV['WEAVENOTE__MAILER_DOMAIN']}"
      return "\"#{FROM_NAME}\" <#{e}>"
    end
  end

end
