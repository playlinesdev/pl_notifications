library pl_notifications;

import 'package:flutter/material.dart';
import 'package:pl_notifications/pl_notification_container.dart';
import 'package:pl_notifications/pl_notification_message.dart';

typedef Duration GetDuration(PlNotificationMessage message);
typedef Widget CreateWidget(
    PlNotificationMessage message, Function removeEntryFunction);
typedef Size PlNotificationSize(BuildContext context);
typedef Widget BasicBuilder(Size screenSize);

///Service class to present notifications
class PlNotifications {
  BuildContext context;
  List<PlNotificationMessage> _notificationMessages = [];
  PlNotifications._();
  OverlayEntry _currentEntry;
  Key _currentKey;
  Alignment _alignment = Alignment.bottomCenter;
  PlNotificationSize _notificationSize = (ctx) {
    var size = MediaQuery.of(ctx).size;
    return Size(size.width * .65, 75);
  };
  GetDuration _baseDuration = (message) => Duration(seconds: 3);
  CreateWidget _baseWidget =
      (PlNotificationMessage message, Function removeEntry) =>
          message.builder != null
              ? message.builder(message)
              : Card(
                  child: Stack(
                    children: <Widget>[
                      ListTile(
                        leading: message.icon,
                        title: message.title,
                        subtitle: message.subtitle,
                        dense: true,
                      ),
                      Positioned(
                        right: 10,
                        child: FlatButton(
                          onPressed: () {
                            removeEntry();
                          },
                          child: Icon(Icons.close, size: 15),
                        ),
                      )
                    ],
                  ),
                );

  static PlNotifications _instance;

  ///Returns a singleton instance of this class only renewing the BuildContext
  ///related to it
  static PlNotifications of(BuildContext context) {
    if (_instance == null) _instance = PlNotifications._();
    _instance.context = context;
    return _instance;
  }

  ///Used to setup the notifications for the whole project so that it's not
  ///necessary to pass it everytime
  ///
  ///* [duration] A function that receives the notification message and returns the duration it has to have
  ///* [widget] A function that receives the notification message and returns the widget to display it
  ///* [alignment] The alignment for the notification
  ///* [notificationSize] A function that receives a context and returns a Size that is the size of the notification
  static setup({
    GetDuration duration,
    CreateWidget widget,
    Alignment alignment,
    PlNotificationSize notificationSize,
  }) {
    var notifications = of(null);
    notifications._baseDuration = duration;
    notifications._baseWidget = widget;
    notifications._notificationSize = notificationSize;
    notifications._alignment = alignment;
  }

  bool get presentingNotifications => _currentEntry != null;

  OverlayEntry _createEntry(Widget widget) => OverlayEntry(
        builder: (BuildContext context) => widget,
      );

  ///Starts presenting the notifications queued.
  void show() {
    if (_notificationMessages.isEmpty) return;
    var firstMessage = _notificationMessages.removeAt(0);
    var size = firstMessage.builder != null
        ? Size(null, null)
        : _notificationSize(context);
    Duration duration = firstMessage.duration == null
        ? _baseDuration(firstMessage)
        : firstMessage.duration;

    _currentKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
    _currentEntry = _createEntry(
      Stack(
        children: <Widget>[
          Align(
            alignment: _alignment,
            child: PlNotificationContainer(
              _baseWidget(firstMessage, _removeCurrentEntry),
              Duration(milliseconds: 400),
              width: size.width,
              height: size.height,
              curve: Curves.bounceInOut,
              onEnd: () {
                var key = _currentKey;
                Future.delayed(duration).then((value) {
                  if (_currentKey == key) {
                    _removeCurrentEntry();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_currentEntry);
  }

  void _removeCurrentEntry() {
    if (_currentEntry != null) {
      _currentEntry.remove();
      _currentEntry = null;
    }
  }

  void _add(PlNotificationMessage message) {
    _notificationMessages.add(message);
    if (!presentingNotifications) {
      show();
    }
  }

  void clearAll() {
    _reset();
  }

  void _reset() {
    _notificationMessages.clear();
    _removeCurrentEntry();
  }

  ///Schedule a notification message
  static void showMessage(
    BuildContext context,
    Widget title, {
    Widget subtitle,
    Duration duration,
    Widget icon,
  }) {
    showCustomNotification(
      context,
      title: title,
      subtitle: subtitle,
      duration: duration,
      icon: icon,
    );
  }

  ///Schedule an info notification
  static void showInfo(BuildContext context, Widget title,
      {Widget subtitle, Duration duration, Color color = Colors.blue}) {
    showMessage(
      context,
      title,
      subtitle: subtitle,
      duration: duration,
      icon: Icon(Icons.info, color: color),
    );
  }

  ///A shortcut for showing custom notifications
  static void showWidgetNotification(
      BuildContext context, BasicBuilder builder) {
    var size = MediaQuery.of(context).size;
    showCustomNotification(context, builder: (nm) => builder(size));
  }

  ///Main method for showing notifications where you can pass all the parameters
  static void showCustomNotification(
    BuildContext context, {
    Widget Function(PlNotificationMessage message) builder,
    Widget title,
    Widget subtitle,
    Widget icon,
    Duration duration,
  }) {
    var notifications = PlNotifications.of(context);
    notifications._reset();
    notifications._add(
      PlNotificationMessage(
        title: title,
        duration: duration,
        icon: icon,
        subtitle: subtitle,
        builder: builder,
      ),
    );
  }

  ///Schedule a success notification
  static void showError(BuildContext context, String title,
      {String subtitle, Duration duration, Color color = Colors.red}) {
    showMessage(
      context,
      Text(title),
      subtitle: Text(subtitle),
      duration: duration,
      icon: Icon(Icons.error, color: color),
    );
  }

  ///Schedule a success notification
  static void showSuccess(BuildContext context, String title,
      {String subtitle, Duration duration, Color color = Colors.green}) {
    showMessage(
      context,
      Text(title),
      subtitle: Text(subtitle),
      duration: duration,
      icon: Icon(Icons.check_box, color: color),
    );
  }
}
