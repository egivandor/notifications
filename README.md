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

## Usage

Render notification icons:

    <%= render 'notifications/shared/notifications', ntype: :reports, nicon: 'exclamation-triangle', nclass: 'danger' %>
    <%= render 'notifications/shared/notifications', ntype: :messages, nicon: 'envelope', nclass: 'info'%>
    <%= render 'notifications/shared/notifications', ntype: :notifications, nicon: 'bell', nclass: 'warning'%>

Send a desktop notification:

    notifications.CheckNotification.desktopNotify('a', 'b')

## Send messages

Send a notification to one recipient:

    Notifications::Delivery::Simple.new('Test', 'This is a <b>Test</b> message!', nil, Conratesecurity::User.first, nil, :notifications)

## Requirements

* btemplater
* kaminari
