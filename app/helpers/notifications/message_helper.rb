module Notifications
  module MessageHelper
    def self.send_notification(subject, body, recipient)
      Notifications::Delivery::Simple.new.delivery(subject, body, nil, recipient, nil, :notifications)
    end
  end
end