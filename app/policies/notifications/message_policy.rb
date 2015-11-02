module Notifications
  class MessagePolicy < Notifications::ApplicationPolicy
    def permitted_attributes
      [:subject, :body, :recipient_id]
    end

    def new?
      create?
    end

    def create?
      ['reports', 'messages'].include? @record.messagetype
    end
  end
end