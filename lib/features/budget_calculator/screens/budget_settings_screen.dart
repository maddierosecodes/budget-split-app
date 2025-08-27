import 'package:evenedge/widgets/common/app_bar_title.dart';
import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class BudgetSettingsScreen extends StatefulWidget {
  const BudgetSettingsScreen({super.key});

  @override
  State<BudgetSettingsScreen> createState() => _BudgetSettingsScreenState();
}

class _BudgetSettingsScreenState extends State<BudgetSettingsScreen> {
  String _selectedOption = '50/50';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const AppBarTitle(title: 'Budget Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RadioListTile<String>(
              title: const Text('50/50'),
              value: '50/50',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('% Split'),
              value: '% Split',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('EvenEdge'),
              value: 'EvenEdge',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: () {
                // For now, just pop the screen
                Navigator.of(context).pop();
              },
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
