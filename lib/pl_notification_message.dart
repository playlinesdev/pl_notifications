import 'package:flutter/material.dart';

///Class with information to define a notification message. If the
///widget property is set, will present that widget, if not, will present the
///Notifications base widget which is a ListTile
class PlNotificationMessage {
  final Icon icon;
  final String title;
  final String subtitle;
  final Duration duration;
  PlNotificationMessage(
    this.title,
    this.duration, {
    this.icon,
    this.subtitle,
  });
}
