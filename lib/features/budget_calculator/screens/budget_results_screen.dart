import 'package:evenedge/widgets/common/back_button.dart';
import 'package:flutter/material.dart';

class BudgetResultsScreen extends StatelessWidget {
  const BudgetResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Budget Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Results', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            const Text('Partner 1 should pay: £1200'),
            const Text('Partner 1 will have left: £300'),
            const SizedBox(height: 8),
            const Text('Partner 2 should pay: £800'),
            const Text('Partner 2 will have left: £700'),
          ],
        ),
      ),
    );
  }
}
