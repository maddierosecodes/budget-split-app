import 'package:evenedge/features/budget_calculator/screens/budget_calculator_screen.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_input_screen.dart';
import 'package:evenedge/features/settings/screens/settings_screen.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FairSplitInputScreen(),
                  ),
                );
              },
              text: 'Fair Split Calculator',
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BudgetCalculatorScreen(),
                  ),
                );
              },
              text: 'Budget Calculator',
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
