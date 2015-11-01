module Notifications
  class MessagesController < Notifications::ApplicationController
    helper Btemplater::ApplicationHelper
    helper Btemplater::IndexHelper
    helper Btemplater::NewHelper
    include Btemplater::Tools

    def index
      messagetype = params[:messagetype]
      @objects = Notifications::Message.where(messagetype: messagetype).order('created_at desc').page(params[:page])
    end

    def new
      @obj = Notifications::Message.new
    end

    def create
      do_create(params, Notifications::Message, notifications.messages_path(params[:messagetype]))
    end

    def count
      render json: Notifications::Message.where(messagetype: params[:messagetype]).count
    end

    def before_save_create(obj)
      obj.recipient_type = Notifications::Engine.config.recipient_class
      obj.messagetype = params[:messagetype]
    end
  end
end
