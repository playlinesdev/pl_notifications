import 'package:flutter/material.dart';

///Class with information to define a notification message. If the
///widget property is set, will present that widget, if not, will present the
///Notifications base widget which is a ListTile
class PlNotificationMessage {
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Duration duration;
  final Widget Function(PlNotificationMessage) builder;
  PlNotificationMessage({
    this.title,
    this.duration,
    this.icon,
    this.subtitle,
    this.builder,
  });
}
