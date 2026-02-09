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

  group('Pill expandable', () {
    testWidgets('toggles expansion on tap when expandable is true',
        (tester) async {
      const longText = 'This is a very long text that should be truncated';
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Desc',
              value: longText,
              expandable: true,
            ),
          ),
        ),
      );

      // Initial state: Truncated
      final textFinder = find.text(longText);
      expect(textFinder, findsOneWidget);
      
      final truncatedText = tester.widget<Text>(textFinder);
      expect(truncatedText.overflow, TextOverflow.ellipsis);

      // Tap to expand
      await tester.tap(find.byType(Pill));
      await tester.pump();

      // Expanded state
      final expandedText = tester.widget<Text>(textFinder);
      expect(expandedText.overflow, null);

      // Tap to collapse
      await tester.tap(find.byType(Pill));
      await tester.pump();

      // Back to truncated
      final collapsedText = tester.widget<Text>(textFinder);
      expect(collapsedText.overflow, TextOverflow.ellipsis);
    });

    testWidgets('does not enter edit mode when expandable is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Desc',
              value: 'Text',
              expandable: true,
              editable: true, // Both true
              onValueChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Pill));
      await tester.pump();

      // Should expand (toggle overflow), not show TextField
      expect(find.byType(TextField), findsNothing);
      
      final textWidget = tester.widget<Text>(find.text('Text'));
      expect(textWidget.overflow, null); // It expanded
    });

    testWidgets('shows summary when provided and collapsed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Desc',
              value: 'Full Text',
              summary: 'Summary',
              expandable: true,
            ),
          ),
        ),
      );

      expect(find.text('Summary'), findsOneWidget);
      expect(find.text('Full Text'), findsNothing);

      // Tap to expand
      await tester.tap(find.byType(Pill));
      await tester.pump();

      expect(find.text('Full Text'), findsOneWidget);
      expect(find.text('Summary'), findsNothing);
    });
  });

  group('Pill selectable', () {
    testWidgets('selected pill has thicker border by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Tag', selected: true),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.width, 2.0);
    });

    testWidgets('unselected pill has normal border width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Tag', selected: false),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.width, 1.0);
    });

    testWidgets('selected pill uses tinted background', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(label: 'Tag', selected: true),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      // Default border color is black, so selected bg should be black with 15% opacity
      expect(decoration.color, isNot(Colors.transparent));
      expect(decoration.color!.a, closeTo(0.15, 0.01));
    });

    testWidgets('selected pill uses custom selectedBackgroundColor',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Tag',
              selected: true,
              style: PillStyle(
                selectedBackgroundColor: Colors.red,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);
    });

    testWidgets('selected pill uses custom selectedBorderWidth',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Tag',
              selected: true,
              style: PillStyle(
                selectedBorderWidth: 3.0,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.width, 3.0);
    });

    testWidgets('shows check icon when selected and showCheckIcon is true',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Tag',
              selected: true,
              showCheckIcon: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('does not show check icon when selected but showCheckIcon is false',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Tag',
              selected: true,
              showCheckIcon: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('does not show check icon when not selected even if showCheckIcon is true',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Tag',
              selected: false,
              showCheckIcon: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('shows check icon with label and value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Plan',
              value: 'Premium',
              selected: true,
              showCheckIcon: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Plan'), findsOneWidget);
      expect(find.text('Premium'), findsOneWidget);
    });

    testWidgets('selected with preset style applies tinted background from preset border color',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Info',
              selected: true,
              style: PillStyles.info,
            ),
          ),
        ),
      );

      final container = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final decoration = container.decoration as BoxDecoration;
      // Should NOT be the normal info background (0xFFE3F2FD)
      // Should be the info border color (0xFF90CAF9) with 15% opacity
      expect(decoration.color, isNot(const Color(0xFFE3F2FD)));
      expect(decoration.color!.a, closeTo(0.15, 0.01));
    });
  });

  group('Pill leading/trailing and Widget content', () {
    testWidgets('renders leading widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Settings',
              leading: Icon(Icons.settings),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('renders trailing widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Next',
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('renders Widget as label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star),
                  Text('Featured'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);
    });

    testWidgets('renders Widget as value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'User',
              value: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.person),
                  Text('Jane'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('User'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text('Jane'), findsOneWidget);
    });

    testWidgets('Widget value disables editing on tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'User',
              value: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.person),
                  Text('Jane'),
                ],
              ),
              editable: true,
              onValueChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Pill));
      await tester.pump();

      // Should not enter edit mode since value is a Widget
      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('leading and showCheckIcon both render', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Tag',
              leading: Icon(Icons.star),
              selected: true,
              showCheckIcon: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Tag'), findsOneWidget);
    });

    testWidgets('leading and trailing with value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Pill(
              label: 'Key',
              value: 'Value',
              leading: Icon(Icons.vpn_key),
              trailing: Icon(Icons.copy),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.vpn_key), findsOneWidget);
      expect(find.byIcon(Icons.copy), findsOneWidget);
      expect(find.text('Key'), findsOneWidget);
      expect(find.text('Value'), findsOneWidget);
    });
  });

  group('Pill Layout', () {
    testWidgets('pill hugs content width when label only', (tester) async {
      // We place the pill in a Center within a SizedBox of width 500.
      // If it expands, it will take up 500 width.
      // If it hugs content, it will be much smaller.
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 500,
                child: Center( // Center allows child to shrink
                  child: Pill(label: 'Short'),
                ),
              ),
            ),
          ),
        ),
      );

      final pillFinder = find.byType(Pill);
      final pillSize = tester.getSize(pillFinder);

      // "Short" + padding + borders is definitely less than 200, and way less than 500.
      expect(pillSize.width, lessThan(200));
    });

    testWidgets('pill hugs content width when label and value present', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 500,
                child: Center(
                  child: Pill(label: 'Key', value: 'Value'),
                ),
              ),
            ),
          ),
        ),
      );

      final pillFinder = find.byType(Pill);
      final pillSize = tester.getSize(pillFinder);

      // "Key" + divider + "Value" + padding is likely under 250.
      expect(pillSize.width, lessThan(250));
    });

    testWidgets('pill hugs content width when editing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 500,
                child: Center(
                  child: Pill(
                    label: 'Key',
                    value: 'Short',
                    onValueChanged: (_) {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Tap to edit
      await tester.tap(find.byType(Pill));
      await tester.pump();

      final pillFinder = find.byType(Pill);
      final pillSize = tester.getSize(pillFinder);

      // Even when editing "Short", it shouldn't blow up to 500 width.
      // It should be roughly the same size as displayed version.
      expect(pillSize.width, lessThan(250));
    });
  });
}
