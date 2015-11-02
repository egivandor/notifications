# Notifications

## Installation

Gemfile.rb

    gem 'notifications', path: '../notifications'

routes.rb

    mount Notifications::Engine => '/notifications'

application.js

    //= require 'notifications/application.js'

application.css

    *= require 'notifications/application.css'

user.rb

    def pretty_name
      email
    end

app_root/config/initializers/notifications.rb

    module Notifications
      class Engine < Rails::Engine
        config.recipient_class = Conratesecurity::User
      end
    end

## Usage

Render notification icons:

    <%= render 'notifications/shared/notifications', ntype: :reports, nicon: 'exclamation-triangle', nclass: 'danger' %>
    <%= render 'notifications/shared/notifications', ntype: :messages, nicon: 'envelope', nclass: 'info'%>
    <%= render 'notifications/shared/notifications', ntype: :notifications, nicon: 'bell', nclass: 'warning'%>

Send a simple notification:

    Notifications::Message.create!(subject: 'Message subject', body: 'Message body', sender: current_user, recipient: User.first, messagetype: :notification, owner: User.first)

Extra: send a desktop notification:

    notifications.CheckNotification.desktopNotify('a', 'b')

## Send messages

Send a notification to one recipient:

    Notifications::Delivery::Simple.new('Test', 'This is a <b>Test</b> message!', nil, Conratesecurity::User.first, nil, :notifications)

## Requirements

* btemplater
* kaminari
