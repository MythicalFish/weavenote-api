module Notify
  extend ActiveSupport::Concern
  included do

    def notify
      Notification.create
    end

  end
end