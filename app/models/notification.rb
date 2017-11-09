class Notification < ApplicationRecord

  TYPE = { mention: 1 }
  belongs_to :receiver, class_name: 'User'
  has_one :creator, class_name: 'User'
  has_one :concern, polymorphic: true

  after_create :send_notification

  def send_notification
    email = NotificationMailer.send_notification(self)
    email.deliver_now 
  end

  def title
    "#{creator.name} mentioned you"
  end

end