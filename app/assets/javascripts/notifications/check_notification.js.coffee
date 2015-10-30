class CheckNotification
  constructor: (path, element, interval) ->
    if typeof Turbolinks != 'undefined'
      $(document).on 'page:change', ->
        mf(path, element, interval)
        return
    else
      $(document).ready ->
        mf(path, element, interval)
        return

  mf = (path, element, interval) ->
    window.setInterval(() ->
      $.get(path, (data) ->
          $(element).html(data);
      , "json" );
    , interval);

  @desktopNotify: (title, body) ->
    if window.webkitNotifications
      if window.webkitNotifications.checkPermission() == 0
        @desktopNotifyWithoutCheck(title, body)
      else
        window.webkitNotifications.requestPermission(()->{});
    else
      return false
  @desktopNotifyWithoutCheck: (title, body) ->
    myNotification = window.webkitNotifications.createNotification('icon.png', title, body);
    myNotification.show();

window.notifications = {}
window.notifications.CheckNotification = CheckNotification