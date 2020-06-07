import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pl_notifications/pl_notification_container.dart';

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
}
