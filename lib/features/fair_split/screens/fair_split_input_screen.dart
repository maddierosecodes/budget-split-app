import 'package:evenedge/features/fair_split/screens/fair_split_results_screen.dart';
import 'package:evenedge/utils/fair_split_calculator.dart';
import 'package:evenedge/utils/currency_input_formatter.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    // Validate form first
    if (!_formKey.currentState!.validate()) {
      // Show error message and scroll to first error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors above before continuing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse input values (guaranteed to be valid numbers due to validation)
    final inputs = FairSplitInputs(
      partner1Income: double.parse(
        _partner1IncomeController.text.isEmpty
            ? '0'
            : _partner1IncomeController.text,
      ),
      partner2Income: double.parse(
        _partner2IncomeController.text.isEmpty
            ? '0'
            : _partner2IncomeController.text,
      ),
      jointIncome: double.parse(
        _jointIncomeController.text.isEmpty ? '0' : _jointIncomeController.text,
      ),
      partner1Outgoings: double.parse(
        _partner1OutgoingsController.text.isEmpty
            ? '0'
            : _partner1OutgoingsController.text,
      ),
      partner2Outgoings: double.parse(
        _partner2OutgoingsController.text.isEmpty
            ? '0'
            : _partner2OutgoingsController.text,
      ),
      jointOutgoings: double.parse(
        _jointOutgoingsController.text.isEmpty
            ? '0'
            : _jointOutgoingsController.text,
      ),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Partner 1 Income',
                controller: _partner1IncomeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [CurrencyInputFormatter()],
                prefixText: '£ ',
                hintText: '0.00',
                validator: (value) =>
                    validateCurrencyInput(value, 'Partner 1 Income'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Partner 2 Income',
                controller: _partner2IncomeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [CurrencyInputFormatter()],
                prefixText: '£ ',
                hintText: '0.00',
                validator: (value) =>
                    validateCurrencyInput(value, 'Partner 2 Income'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Joint Income',
                controller: _jointIncomeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [CurrencyInputFormatter()],
                prefixText: '£ ',
                hintText: '0.00',
                validator: (value) =>
                    validateCurrencyInput(value, 'Joint Income'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Partner 1 Outgoings',
                controller: _partner1OutgoingsController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [CurrencyInputFormatter()],
                prefixText: '£ ',
                hintText: '0.00',
                validator: (value) =>
                    validateCurrencyInput(value, 'Partner 1 Outgoings'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Partner 2 Outgoings',
                controller: _partner2OutgoingsController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [CurrencyInputFormatter()],
                prefixText: '£ ',
                hintText: '0.00',
                validator: (value) =>
                    validateCurrencyInput(value, 'Partner 2 Outgoings'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Joint Outgoings',
                controller: _jointOutgoingsController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [CurrencyInputFormatter()],
                prefixText: '£ ',
                hintText: '0.00',
                validator: (value) =>
                    validateCurrencyInput(value, 'Joint Outgoings'),
              ),
              const SizedBox(height: 32),
              PrimaryButton(onPressed: _calculateFairSplit, text: 'Calculate'),
            ],
          ),
        ),
      ),
    );
  }
}
