module Notifications
  class MessagesController < Notifications::ApplicationController
    helper Btemplater::ApplicationHelper
    helper Btemplater::IndexHelper
    helper Btemplater::ShowHelper
    helper Btemplater::NewHelper
    include Btemplater::Tools

    def index
      messagetype = params[:messagetype]
      @objects = Notifications::Message.where(messagetype: messagetype).where(owner: current_user).order('created_at desc').page(params[:page])
    end

    def show
      @obj = Notifications::Message.find(params[:id])
      @obj.unread = false
      @obj.save!
    end

    def new
      @obj = Notifications::Message.new
    end

    def create
      Notifications::Message.transaction do
        do_create(params, Notifications::Message, notifications.messages_path(params[:messagetype]))
        create_duplicate(@obj)
      end
    end

    def reply
      @prev_obj = Notifications::Message.find(params[:id])
      @obj = Notifications::Message.new
      @obj.parent_id = @prev_obj.id
      @obj.recipient = @prev_obj.sender
      @obj.subject = "#{t('notifications.re')}#{@prev_obj.subject}"
      @obj.body = "\n\n#{@prev_obj.body.split("\n").map{|x| "> #{x}"}.join("\n")}"
    end

    def do_reply
      Notifications::Message.transaction do
        @prev_obj = Notifications::Message.find(params[:id])
        @obj = Notifications::Message.new
        @obj.parent_id = @prev_obj.id
        @obj.recipient = @prev_obj.sender
        @obj.sender = current_user
        @obj.subject = params[:message][:subject]
        @obj.body = params[:message][:body]
        @obj.owner = current_user
        @obj.messagetype = @prev_obj.messagetype
        @obj.unread = false
        @obj.save!
        create_duplicate(@obj)
      end
      redirect_to notifications.messages_path(params[:messagetype])
    end

    def destroy
      @obj = Notifications::Message.find(params[:id])
      @obj.destroy
      redirect_to notifications.messages_path
    end

    def count
      render json: Notifications::Message.where(messagetype: params[:messagetype]).where(unread: true).where(owner: current_user).count
    end

    def before_save_create(obj)
      obj.recipient_type = Notifications::Engine.config.recipient_class
      obj.messagetype = params[:messagetype]
      obj.unread = false
      obj.owner = current_user
      obj.sender = current_user
    end

    private

    def create_duplicate(obj)
      other = obj.dup
      # tmp = other.sender
      other.owner = other.recipient
      other.unread = true
      other.save!
    end
  end
end
