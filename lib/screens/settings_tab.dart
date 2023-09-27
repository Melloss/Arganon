import 'package:flutter/material.dart';
import '../widgets/widgets.dart' show SettingsButton;

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsButton(
          text: 'About',
          onPressed: () {},
        ),
      ],
    );
  }
}
