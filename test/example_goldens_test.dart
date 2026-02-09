@Tags(['golden'])
library;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_widget/pill_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Load Roboto fonts
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

    // Load MaterialIcons font for icon rendering in golden tests
    try {
      final flutterRoot = Platform.environment['FLUTTER_ROOT'] ??
          File(Platform.resolvedExecutable).parent.parent.parent.path;

      final candidates = [
        '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
      ];

      final whichResult = Process.runSync('which', ['flutter']);
      if (whichResult.exitCode == 0) {
        final flutterBin = File(whichResult.stdout.toString().trim()).resolveSymbolicLinksSync();
        final sdkRoot = File(flutterBin).parent.parent.path;
        candidates.add('$sdkRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
      }

      File? iconsFile;
      for (final path in candidates) {
        final f = File(path);
        if (f.existsSync()) {
          iconsFile = f;
          break;
        }
      }

      if (iconsFile != null) {
        final iconFontLoader = FontLoader('MaterialIcons');
        final iconData = await iconsFile.readAsBytes();
        iconFontLoader.addFont(Future.value(ByteData.view(iconData.buffer)));
        await iconFontLoader.load();
        print('✅ Loaded MaterialIcons font');
      } else {
        print('⚠️ MaterialIcons font not found');
      }
    } catch (e) {
      print('⚠️ Could not load MaterialIcons font: $e');
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
        backgroundColor: const Color(0xFFE0E0E0),
        body: Center(
          child: RepaintBoundary(
            key: const ValueKey('golden-boundary'),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            ),
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
      find.byKey(const ValueKey('golden-boundary')),
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
      find.byKey(const ValueKey('golden-boundary')),
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
      find.byKey(const ValueKey('golden-boundary')),
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
      find.byKey(const ValueKey('golden-boundary')),
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
      find.byKey(const ValueKey('golden-boundary')),
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
      find.byKey(const ValueKey('golden-boundary')),
      matchesGoldenFile('../screenshots/readonly_pills.png'),
    );
  });

  testWidgets('Selectable Pills Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Pill(label: 'Default', selected: true),
          Pill(label: 'Success', selected: true, style: PillStyles.success),
          Pill(
            label: 'With Check',
            selected: true,
            showCheckIcon: true,
            style: PillStyles.info,
          ),
          Pill(
            label: 'Plan',
            value: 'Premium',
            selected: true,
            showCheckIcon: true,
            editable: false,
            style: PillStyles.special,
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byKey(const ValueKey('golden-boundary')),
      matchesGoldenFile('../screenshots/selectable_pills.png'),
    );
  });

  testWidgets('Custom Widget Content Golden', (tester) async {
    await tester.pumpWidget(buildTestWrapper(
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          const Pill(
            label: 'Settings',
            leading: Icon(Icons.settings, size: 16),
            style: PillStyles.neutral,
          ),
          const Pill(
            label: 'Next',
            trailing: Icon(Icons.arrow_forward, size: 16),
            style: PillStyles.info,
          ),
          Pill(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.star, size: 16, color: Colors.amber),
                SizedBox(width: 4),
                Text('Featured'),
              ],
            ),
            style: PillStyles.warning,
          ),
          Pill(
            label: 'User',
            value: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.person, size: 16),
                SizedBox(width: 4),
                Text('Jane Doe'),
              ],
            ),
            style: PillStyles.special,
          ),
        ],
      ),
    ));
    await tester.pumpAndSettle();
    await expectLater(
      find.byKey(const ValueKey('golden-boundary')),
      matchesGoldenFile('../screenshots/widget_content_pills.png'),
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
      find.byKey(const ValueKey('golden-boundary')),
      matchesGoldenFile('../screenshots/expandable_pills.png'),
    );
  });
}
