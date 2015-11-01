module Notifications
  class MessagePolicy < Notifications::ApplicationPolicy
    def permitted_attributes
      [:subject, :body, :recipient_id]
    end
  end
end