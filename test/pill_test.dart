import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_widget/pill_widget.dart';

void main() {
  group('Pill', () {
    testWidgets('displays label only when value is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Status'),
          ),
        ),
      );

      expect(find.text('Status'), findsOneWidget);
    });

    testWidgets('displays label and value when value is provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Name', value: 'John'),
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('John'), findsOneWidget);
    });

    testWidgets('enters edit mode on tap when value is provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Name',
              value: 'John',
              onValueChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Pill));
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('calls onValueChanged when value is submitted',
        (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Name',
              value: 'John',
              onValueChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Pill));
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'Jane');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(changedValue, 'Jane');
    });
  });
}
