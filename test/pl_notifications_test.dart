import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pl_notifications/pl_notification_container.dart';
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

void main() {
  testWidgets('Should not produce any exception', (tester) async {
    await tester.pumpWidget(
      PlNotificationContainer(
        Card(
          child: ListTile(
            title: Text('A Title'),
            subtitle: Text('A subttitle'),
            trailing: FlatButton(
                onPressed: () {}, child: Icon(Icons.close, size: 15)),
          ),
        ),
        Duration(seconds: 2),
      ),
    );

    expect(tester.takeException(), null);
  });
  testWidgets('Example should not produce exceptions', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Example()),
    );
    expect(tester.takeException(), null);
  });
  testWidgets('Example should show the notifications properly', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Example()));
    expect(tester.takeException(), null);

    var buttons = find.byWidgetPredicate((widget) =>
        widget is FlatButton &&
        widget.child is Row &&
        (widget.child as Row).children.first is Icon);

    expect(buttons, findsNWidgets(3));

    await tester.tap(buttons.at(0));

    await tester.pump();
    await tester.pump();
    expect(tester.takeException(), null);

    var notificationCard = find.byWidgetPredicate((widget) => widget is Card);
    expect(notificationCard, findsNWidgets(1));

    var checkIcon = find.descendant(
      of: notificationCard,
      matching: find.byIcon(Icons.check_box),
    );

    expect(checkIcon, findsNWidgets(1));
  });
}
