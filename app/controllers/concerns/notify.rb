module Notify
  extend ActiveSupport::Concern
  included do

    def notify receiver, type, concern
      Notification.create({
        receiver: receiver,
        notification_type: type,
        concern: concern
      })
    end

  end
end