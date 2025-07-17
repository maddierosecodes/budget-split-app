import 'package:evenedge/utils/fair_split_calculator.dart';
import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/household_info_box.dart';
import 'package:evenedge/widgets/common/result_box.dart';
import 'package:flutter/material.dart';

class FairSplitResultsScreen extends StatelessWidget {
  const FairSplitResultsScreen({
    required this.results,
    required this.inputs,
    super.key,
  });

  final FairSplitCalculatorResults results;
  final FairSplitInputs inputs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Fair Split Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Household Information Box
            HouseholdInfoBox(
              partner1Income: inputs.partner1Income,
              partner2Income: inputs.partner2Income,
              jointIncome: inputs.jointIncome,
              partner1Outgoings: inputs.partner1Outgoings,
              partner2Outgoings: inputs.partner2Outgoings,
              jointOutgoings: inputs.jointOutgoings,
            ),
            const SizedBox(height: 20),

            // Results
            ResultBox(
              title: results.fiftyFiftySplit.title,
              jointBillsScenarioName:
                  results.fiftyFiftySplit.jointBillsScenario.scenarioName,
              jointPartner1Spend:
                  results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
              jointPartner1Remaining:
                  results.fiftyFiftySplit.jointBillsScenario.partner1Remaining,
              jointPartner2Spend:
                  results.fiftyFiftySplit.jointBillsScenario.partner2Spend,
              jointPartner2Remaining:
                  results.fiftyFiftySplit.jointBillsScenario.partner2Remaining,
              separateBillsScenarioName:
                  results.fiftyFiftySplit.separateBillsScenario.scenarioName,
              separatePartner1Spend:
                  results.fiftyFiftySplit.separateBillsScenario.partner1Spend,
              separatePartner1Remaining: results
                  .fiftyFiftySplit
                  .separateBillsScenario
                  .partner1Remaining,
              separatePartner2Spend:
                  results.fiftyFiftySplit.separateBillsScenario.partner2Spend,
              separatePartner2Remaining: results
                  .fiftyFiftySplit
                  .separateBillsScenario
                  .partner2Remaining,
            ),
            const SizedBox(height: 16),
            ResultBox(
              title: results.percentageSplit.title,
              jointBillsScenarioName:
                  results.percentageSplit.jointBillsScenario.scenarioName,
              jointPartner1Spend:
                  results.percentageSplit.jointBillsScenario.partner1Spend,
              jointPartner1Remaining:
                  results.percentageSplit.jointBillsScenario.partner1Remaining,
              jointPartner2Spend:
                  results.percentageSplit.jointBillsScenario.partner2Spend,
              jointPartner2Remaining:
                  results.percentageSplit.jointBillsScenario.partner2Remaining,
              separateBillsScenarioName:
                  results.percentageSplit.separateBillsScenario.scenarioName,
              separatePartner1Spend:
                  results.percentageSplit.separateBillsScenario.partner1Spend,
              separatePartner1Remaining: results
                  .percentageSplit
                  .separateBillsScenario
                  .partner1Remaining,
              separatePartner2Spend:
                  results.percentageSplit.separateBillsScenario.partner2Spend,
              separatePartner2Remaining: results
                  .percentageSplit
                  .separateBillsScenario
                  .partner2Remaining,
            ),
            const SizedBox(height: 16),
            ResultBox(
              title: results.evenEdgeSplit.title,
              jointBillsScenarioName:
                  results.evenEdgeSplit.jointBillsScenario.scenarioName,
              jointPartner1Spend:
                  results.evenEdgeSplit.jointBillsScenario.partner1Spend,
              jointPartner1Remaining:
                  results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
              jointPartner2Spend:
                  results.evenEdgeSplit.jointBillsScenario.partner2Spend,
              jointPartner2Remaining:
                  results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
              separateBillsScenarioName:
                  results.evenEdgeSplit.separateBillsScenario.scenarioName,
              separatePartner1Spend:
                  results.evenEdgeSplit.separateBillsScenario.partner1Spend,
              separatePartner1Remaining:
                  results.evenEdgeSplit.separateBillsScenario.partner1Remaining,
              separatePartner2Spend:
                  results.evenEdgeSplit.separateBillsScenario.partner2Spend,
              separatePartner2Remaining:
                  results.evenEdgeSplit.separateBillsScenario.partner2Remaining,
            ),
          ],
        ),
      ),
    );
  }
}
