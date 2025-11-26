import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_widget/pill_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final fontPath = '${Directory.current.path}/test/fonts/Roboto-Regular.ttf';
    final fontFile = File(fontPath);
    
    if (!fontFile.existsSync()) {
      print('⚠️ Font file not found at: $fontPath');
      return;
    }

    try {
      final fontLoader = FontLoader('Roboto');
      
      final regularData = await fontFile.readAsBytes();
      fontLoader.addFont(Future.value(ByteData.view(regularData.buffer)));

      final boldFile = File('${Directory.current.path}/test/fonts/Roboto-Bold.ttf');
      if (boldFile.existsSync()) {
        final boldData = await boldFile.readAsBytes();
        fontLoader.addFont(Future.value(ByteData.view(boldData.buffer)));
      }

      await fontLoader.load();
      print('✅ Loaded font Roboto (Regular & Bold) from test/fonts/');
    } catch (e) {
      print('❌ Failed to load font: $e');
    }
  });

  Widget buildTestWrapper(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  testWidgets('Basic Pills Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(label: 'Active'),
          Pill(label: 'Premium'),
          Pill(label: 'Status', value: 'Online'),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/basic_pills.png'),
    );
  });

  testWidgets('Editable Pills Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(
            label: 'Name',
            value: 'John Doe',
            onValueChanged: (_) {},
          ),
          Pill(
            label: 'Email',
            value: 'john@example.com',
            onValueChanged: (_) {},
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/editable_pills.png'),
    );
  });

  testWidgets('Styled Pills (Presets) Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(label: 'Info', style: PillStyles.info),
          Pill(label: 'Success', style: PillStyles.success),
          Pill(label: 'Warning', style: PillStyles.warning),
          Pill(label: 'Error', style: PillStyles.error),
          Pill(label: 'Special', style: PillStyles.special),
          Pill(label: 'Neutral', style: PillStyles.neutral),
          Pill(label: 'Muted', style: PillStyles.muted),
          Pill(label: 'Date', style: PillStyles.date),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/styled_pills.png'),
    );
  });

  testWidgets('Styled Pills with Values Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(
            label: 'Email',
            value: 'user@example.com',
            style: PillStyles.info,
          ),
          Pill(
            label: 'Status',
            value: 'Verified',
            style: PillStyles.success,
          ),
          Pill(
            label: 'Expires',
            value: 'Dec 31, 2024',
            style: PillStyles.date,
          ),
          Pill(
            label: 'Role',
            value: 'Administrator',
            style: PillStyles.special,
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/styled_values_pills.png'),
    );
  });

  testWidgets('Custom Styles Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(
            label: 'Custom',
            value: 'Amber Theme',
            style: PillStyle(
              backgroundColor: Colors.amber.shade50,
              borderColor: Colors.amber.shade300,
              labelColor: Colors.amber.shade900,
            ),
          ),
          Pill(
            label: 'Rounded',
            value: 'More radius',
            style: PillStyle(
              backgroundColor: Colors.teal.shade50,
              borderColor: Colors.teal.shade300,
              labelColor: Colors.teal.shade800,
              borderRadius: 32,
            ),
          ),
          Pill(
            label: 'Thick Border',
            style: PillStyle(
              borderColor: Colors.indigo,
              labelColor: Colors.indigo,
              borderWidth: 2.0,
            ),
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/custom_pills.png'),
    );
  });

  testWidgets('Read-only Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(
            label: 'Click Me',
            value: 'Non-editable',
            editable: false,
            style: PillStyles.info,
            onTap: () {},
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/readonly_pills.png'),
    );
  });

  testWidgets('Expandable Pills Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(
            label: 'Description',
            value: 'Long text that will be truncated by default.',
            expandable: true,
            style: PillStyles.neutral,
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('../screenshots/expandable_pills.png'),
    );
  });
}
