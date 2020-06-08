import 'package:flutter/material.dart';
import 'package:pl_notifications/pl_notifications.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A PlNotifications test')),
      persistentFooterButtons: <Widget>[
        FlatButton.icon(
          onPressed: () {
            PlNotifications.showSuccess(context, 'title');
          },
          icon: Icon(Icons.check_box, color: Colors.green),
          label: Text('Success Notification'),
        ),
        FlatButton.icon(
          onPressed: () {
            PlNotifications.showError(context, 'title');
          },
          icon: Icon(Icons.error, color: Colors.red),
          label: Text('Error Notification'),
        ),
        FlatButton.icon(
          onPressed: () {
            PlNotifications.showMessage(context, Text('title'));
          },
          icon: Icon(Icons.message),
          label: Text('Regular Notification'),
        ),
      ],
    );
  }
}
