import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/custom_text_field.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class BudgetOutgoingScreen extends StatelessWidget {
  const BudgetOutgoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Budget Outgoing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomTextField(labelText: 'Partner 1 Outgoings'),
            const SizedBox(height: 16),
            const CustomTextField(labelText: 'Partner 2 Outgoings'),
            const SizedBox(height: 16),
            const CustomTextField(labelText: 'Joint Outgoings'),
            const SizedBox(height: 32),
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
