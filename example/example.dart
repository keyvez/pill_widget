import 'package:flutter/material.dart';
import 'package:pill_widget/pill_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pill Widget Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PillWidgetExample(),
    );
  }
}

class PillWidgetExample extends StatefulWidget {
  const PillWidgetExample({super.key});

  @override
  State<PillWidgetExample> createState() => _PillWidgetExampleState();
}

class _PillWidgetExampleState extends State<PillWidgetExample> {
  String _name = 'John Doe';
  String _email = 'john@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pill Widget Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Pills Section
            const Text(
              'Basic Pills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // Label-only pill (default style)
                const Pill(label: 'Active'),
                const Pill(label: 'Premium'),

                // Label with value
                const Pill(label: 'Status', value: 'Online'),
              ],
            ),

            const SizedBox(height: 24),

            // Editable Pills Section
            const Text(
              'Editable Pills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Name',
                  value: _name,
                  onValueChanged: (newValue) {
                    setState(() {
                      _name = newValue;
                    });
                  },
                ),
                Pill(
                  label: 'Email',
                  value: _email,
                  onValueChanged: (newValue) {
                    setState(() {
                      _email = newValue;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Styled Pills Section (using presets)
            const Text(
              'Styled Pills (Presets)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const Pill(label: 'Info', style: PillStyles.info),
                const Pill(label: 'Success', style: PillStyles.success),
                const Pill(label: 'Warning', style: PillStyles.warning),
                const Pill(label: 'Error', style: PillStyles.error),
                const Pill(label: 'Special', style: PillStyles.special),
                const Pill(label: 'Neutral', style: PillStyles.neutral),
                const Pill(label: 'Muted', style: PillStyles.muted),
                const Pill(label: 'Date', style: PillStyles.date),
              ],
            ),

            const SizedBox(height: 24),

            // Styled Pills with Values
            const Text(
              'Styled Pills with Values',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const Pill(
                  label: 'Email',
                  value: 'user@example.com',
                  style: PillStyles.info,
                ),
                const Pill(
                  label: 'Status',
                  value: 'Verified',
                  style: PillStyles.success,
                ),
                const Pill(
                  label: 'Expires',
                  value: 'Dec 31, 2024',
                  style: PillStyles.date,
                ),
                const Pill(
                  label: 'Role',
                  value: 'Administrator',
                  style: PillStyles.special,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Custom Style
            const Text(
              'Custom Styles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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

            const SizedBox(height: 24),

            // Expandable Pill
            const Text(
              'Expandable Pill',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap to expand/collapse long content',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Description',
                  value:
                      'This is a very long description that will be truncated by default but can be expanded by tapping on the pill. It demonstrates the expandable feature.',
                  expandable: true,
                  style: PillStyles.neutral,
                ),
                Pill(
                  label: 'Notes',
                  value: 'Short note',
                  expandable: true,
                  style: PillStyles.muted,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Read-only with onTap
            const Text(
              'Read-only with Tap Handler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Click Me',
                  value: 'Non-editable',
                  editable: false,
                  style: PillStyles.info,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pill tapped!')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
