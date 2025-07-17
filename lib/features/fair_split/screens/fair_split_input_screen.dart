import 'package:evenedge/features/fair_split/screens/fair_split_results_screen.dart';
import 'package:evenedge/utils/fair_split_calculator.dart';
import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/custom_text_field.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class FairSplitInputScreen extends StatefulWidget {
  const FairSplitInputScreen({super.key});

  @override
  State<FairSplitInputScreen> createState() => _FairSplitInputScreenState();
}

class _FairSplitInputScreenState extends State<FairSplitInputScreen> {
  final TextEditingController _partner1IncomeController =
      TextEditingController();
  final TextEditingController _partner2IncomeController =
      TextEditingController();
  final TextEditingController _jointIncomeController = TextEditingController();
  final TextEditingController _partner1OutgoingsController =
      TextEditingController();
  final TextEditingController _partner2OutgoingsController =
      TextEditingController();
  final TextEditingController _jointOutgoingsController =
      TextEditingController();

  @override
  void dispose() {
    _partner1IncomeController.dispose();
    _partner2IncomeController.dispose();
    _jointIncomeController.dispose();
    _partner1OutgoingsController.dispose();
    _partner2OutgoingsController.dispose();
    _jointOutgoingsController.dispose();
    super.dispose();
  }

  void _calculateFairSplit() {
    // Parse input values, defaulting to 0 if parsing fails
    final inputs = FairSplitInputs(
      partner1Income: double.tryParse(_partner1IncomeController.text) ?? 0,
      partner2Income: double.tryParse(_partner2IncomeController.text) ?? 0,
      jointIncome: double.tryParse(_jointIncomeController.text) ?? 0,
      partner1Outgoings:
          double.tryParse(_partner1OutgoingsController.text) ?? 0,
      partner2Outgoings:
          double.tryParse(_partner2OutgoingsController.text) ?? 0,
      jointOutgoings: double.tryParse(_jointOutgoingsController.text) ?? 0,
    );

    // Calculate results using the utility function
    final results = FairSplitCalculator.calculate(inputs);

    // Navigate to results screen with calculated results and inputs
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            FairSplitResultsScreen(results: results, inputs: inputs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Fair Split Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Partner 1 Income',
              controller: _partner1IncomeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Partner 2 Income',
              controller: _partner2IncomeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Joint Income',
              controller: _jointIncomeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Partner 1 Outgoings',
              controller: _partner1OutgoingsController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Partner 2 Outgoings',
              controller: _partner2OutgoingsController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Joint Outgoings',
              controller: _jointOutgoingsController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            PrimaryButton(onPressed: _calculateFairSplit, text: 'Calculate'),
          ],
        ),
      ),
    );
  }
}
