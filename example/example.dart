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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Label-only pill
            const Pill(label: 'Active'),
            const Pill(label: 'Premium'),

            // Editable pills
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
      ),
    );
  }
}
