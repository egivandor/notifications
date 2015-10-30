module Notifications
  module Delivery
    class Simple
      def initialize(
        subject, body, sender, recipient, parent_id, messagetype
      )
        delivery subject, body, sender, recipient, parent_id, messagetype
      end

      def delivery(subject, body, sender, recipient, parent_id, messagetype)
        Notifications::Message.create!(
          subject: subject,
          body: body,
          sender: sender,
          recipient: recipient,
          parent_id: parent_id,
          messagetype: messagetype
        )
      end
    end
  end
end
