module Notifications
  class Message < ActiveRecord::Base
    belongs_to :recipient, polymorphic: true
    belongs_to :sender, polymorphic: true
    belongs_to :owner, polymorphic: true

    validates :subject, presence: true
  end
end
