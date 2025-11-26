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
      appBar: AppBar(title: const Text('Pill Widget Example')),
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
                  label: 'Email Address',
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
                  label: 'Story',
                  value:
                      '''From 1340, English monarchs, beginning with the Plantagenet king Edward III, asserted that they were the rightful kings of France. They fought the Hundred Years' War (1337–1453) in part to enforce this claim, though ultimately without success. From the early 16th century, the claim had lost any realistic prospect of fulfilment, but every English and later British monarch from Edward III to George III styled themselves king or queen of France until 1801.

                      Edward's claim was through his mother, Isabella, sister of the last direct-line Capetian king of France, Charles IV. Women were excluded from inheriting the French crown and Edward was Charles's nearest male relative. On Charles's death in 1328, however, the French magnates supported Philip VI, who became the first king of the House of Valois, a cadet branch of the Capetian dynasty. Philip was Charles's nearest male-line relative. French jurists much later argued that it was a fundamental law of the kingdom that the crown could not be inherited through the female line. This was supposedly based on the 6th-century Frankish legal code known as the Salic law; however, the Salic law was not mentioned in connection with Edward's claim until the 15th century, and the link to it was tenuous in any case.

                      Edward, whose main concern was to protect his French fief of Gascony, spent much of his reign at war with the Valois kings but never secured the crown. His great-grandson, Henry V, following his crushing victory at Agincourt, was able to impose the Treaty of Troyes on the French in 1420. This stipulated that he and his heirs would succeed the Valois king Charles VI on his death. Both kings died in 1422, and Henry's son Henry VI was crowned king of both countries, creating the so-called "dual monarchy". However, he was not recognised as king in southern France. French resistance to the dual monarchy resulted in the English being expelled from France by 1453, ending the Hundred Years' War, and leaving Calais as the last remaining English possession there.

                      Later English attempts to win the French throne failed, the last being an invasion by Henry VIII in 1523. Calais was lost in 1558. England and France continued to fight wars but none was over the claim to the crown. The use of the title by English and later by British monarchs was ignored by the French, as the claim had long ceased to have any practical significance. However, following the French Revolution, the new republican government of France objected to the practice and the title was no longer used from 1801. The claim was finally abandoned the following year.''',
                  summary:
                      'English claim to the French throne (1340–1801) (tap to see more)',
                  expandable: true,
                  style: PillStyles.neutral,
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
