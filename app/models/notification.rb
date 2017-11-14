class Notification < ApplicationRecord

  belongs_to :receiver, class_name: 'User'
  belongs_to :concern, polymorphic: true

  after_create :send_notification

  alias_attribute :type, :notification_type

  def creator
    concern.try(:user)
  end
  
  def url
    domain = ENV['WEAVENOTE__SITE_URL']
    if concern.class.name == 'Comment'
      "#{domain}/projects/#{concern.project.id}"
    end
  end

  # private

  def send_notification
    email = NotificationMailer.send_notification(self)
    email.deliver_now 
  end

end