module Notifications
  class Message < ActiveRecord::Base
    belongs_to :recipient, polymorphic: true
    belongs_to :sender, polymorphic: true
  end
end
