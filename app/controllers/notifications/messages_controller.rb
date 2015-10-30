module Notifications
  class MessagesController < Notifications::ApplicationController
    helper Btemplater::IndexHelper

    def index
      messagetype = params[:messagetype]
      @notifications = Notifications::Message.where(messagetype: messagetype).order('created_at desc')
    end

    def count
      render json: Notifications::Message.where(messagetype: params[:messagetype]).count
    end
  end
end
