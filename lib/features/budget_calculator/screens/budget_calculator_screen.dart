import 'package:evenedge/features/budget_calculator/screens/budget_incoming_screen.dart';
import 'package:evenedge/features/budget_calculator/screens/budget_outgoing_screen.dart';
import 'package:evenedge/features/budget_calculator/screens/budget_results_screen.dart';
import 'package:evenedge/features/budget_calculator/screens/budget_settings_screen.dart';
import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class BudgetCalculatorScreen extends StatelessWidget {
  const BudgetCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Budget Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BudgetIncomingScreen(),
                  ),
                );
              },
              text: 'Incoming',
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BudgetOutgoingScreen(),
                  ),
                );
              },
              text: 'Outgoing',
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BudgetSettingsScreen(),
                  ),
                );
              },
              text: 'Settings',
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BudgetResultsScreen(),
                  ),
                );
              },
              text: 'Results',
            ),
          ],
        ),
      ),
    );
  }
}
