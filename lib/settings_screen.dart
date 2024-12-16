import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  bool _switchValue3 = false;
  bool _switchValue4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Minimize Walking'),
              subtitle: const Text('Prioritize trips with less walking in trip planner'), // Optional subtitle
              value: _switchValue1,
              onChanged: (newValue) {
                setState(() {
                  _switchValue1 = newValue;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Accessibility info'),
              subtitle: const Text('Identify step-free options'),
              value: _switchValue2,
              onChanged: (newValue) {
                setState(() {
                  _switchValue2 = newValue;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Line Colors'),
              subtitle: const Text('Use written names for color-based lines like "Green Line"'),
              value: _switchValue3,
              onChanged: (newValue) {
                setState(() {
                  _switchValue3 = newValue;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Colorblind Mode'),
              subtitle: const Text('Use colorblind friendly accessibility options throughout the app.'),
              value: _switchValue4,
              onChanged: (newValue) {
                setState(() {
                  _switchValue4 = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

