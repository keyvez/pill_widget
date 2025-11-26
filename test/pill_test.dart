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

    testWidgets('does not enter edit mode when editable is false',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Name',
              value: 'John',
              editable: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Pill));
      await tester.pump();

      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Click Me',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Pill));
      await tester.pump();

      expect(tapped, true);
    });
  });

  group('PillStyle', () {
    testWidgets('applies custom background color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Styled',
              style: PillStyle(
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.blue);
    });

    testWidgets('applies custom border color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Styled',
              style: PillStyle(
                borderColor: Colors.red,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isA<Border>());
      final border = decoration.border as Border;
      expect(border.top.color, Colors.red);
    });

    testWidgets('applies custom border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Styled',
              style: PillStyle(
                borderRadius: 32.0,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.borderRadius,
        const BorderRadius.all(Radius.circular(32.0)),
      );
    });
  });

  group('PillStyles presets', () {
    testWidgets('PillStyles.info applies blue theme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Info', style: PillStyles.info),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFFE3F2FD));
    });

    testWidgets('PillStyles.success applies green theme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Success', style: PillStyles.success),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFFE8F5E9));
    });

    testWidgets('PillStyles.error applies red theme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Error', style: PillStyles.error),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFFFFEBEE));
    });
  });

  group('PillStyle methods', () {
    test('copyWith creates new instance with updated values', () {
      const original = PillStyle(
        backgroundColor: Colors.blue,
        borderColor: Colors.red,
      );

      final copied = original.copyWith(backgroundColor: Colors.green);

      expect(copied.backgroundColor, Colors.green);
      expect(copied.borderColor, Colors.red);
    });

    test('merge combines two styles', () {
      const base = PillStyle(
        backgroundColor: Colors.blue,
        borderColor: Colors.red,
      );
      const overlay = PillStyle(
        backgroundColor: Colors.green,
      );

      final merged = base.merge(overlay);

      expect(merged.backgroundColor, Colors.green);
      expect(merged.borderColor, Colors.red);
    });

    test('merge returns original when other is null', () {
      const base = PillStyle(backgroundColor: Colors.blue);

      final merged = base.merge(null);

      expect(merged.backgroundColor, Colors.blue);
    });
  });
}
