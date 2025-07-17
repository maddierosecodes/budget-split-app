import 'dart:developer' as developer;

class FairSplitInputs {
  final double partner1Income;
  final double partner2Income;
  final double jointIncome;
  final double partner1Outgoings;
  final double partner2Outgoings;
  final double jointOutgoings;

  FairSplitInputs({
    required this.partner1Income,
    required this.partner2Income,
    required this.jointIncome,
    required this.partner1Outgoings,
    required this.partner2Outgoings,
    required this.jointOutgoings,
  });
}

class FairSplitScenario {
  final String scenarioName;
  final String partner1Spend;
  final String partner1Remaining;
  final String partner2Spend;
  final String partner2Remaining;

  FairSplitScenario({
    required this.scenarioName,
    required this.partner1Spend,
    required this.partner1Remaining,
    required this.partner2Spend,
    required this.partner2Remaining,
  });
}

class FairSplitResult {
  final String title;
  final FairSplitScenario jointBillsScenario;
  final FairSplitScenario separateBillsScenario;

  FairSplitResult({
    required this.title,
    required this.jointBillsScenario,
    required this.separateBillsScenario,
  });
}

class FairSplitCalculatorResults {
  final FairSplitResult fiftyFiftySplit;
  final FairSplitResult percentageSplit;
  final FairSplitResult evenEdgeSplit;

  FairSplitCalculatorResults({
    required this.fiftyFiftySplit,
    required this.percentageSplit,
    required this.evenEdgeSplit,
  });
}

class FairSplitCalculator {
  // Set this to true to enable debug logging
  static const bool _debugMode = true;

  static void _debugLog(String message) {
    if (_debugMode) {
      developer.log(message, name: 'FairSplitCalculator');
      print('[FairSplitCalculator] $message');
    }
  }

  static void _debugLogInputs(FairSplitInputs inputs) {
    if (_debugMode) {
      _debugLog('=== INPUTS ===');
      _debugLog(
        'Partner 1 Income: £${inputs.partner1Income.toStringAsFixed(2)}',
      );
      _debugLog(
        'Partner 2 Income: £${inputs.partner2Income.toStringAsFixed(2)}',
      );
      _debugLog('Joint Income: £${inputs.jointIncome.toStringAsFixed(2)}');
      _debugLog(
        'Partner 1 Outgoings: £${inputs.partner1Outgoings.toStringAsFixed(2)}',
      );
      _debugLog(
        'Partner 2 Outgoings: £${inputs.partner2Outgoings.toStringAsFixed(2)}',
      );
      _debugLog(
        'Joint Outgoings: £${inputs.jointOutgoings.toStringAsFixed(2)}',
      );
      _debugLog('==============');
    }
  }

  static void _debugLogStep(
    String stepNumber,
    String description, {
    Map<String, double>? values,
  }) {
    if (_debugMode) {
      _debugLog('');
      _debugLog('$stepNumber: $description');
      if (values != null) {
        values.forEach((key, value) {
          _debugLog('  $key: £${value.toStringAsFixed(2)}');
        });
      }
    }
  }

  static void _debugLogScenario(String scenarioName) {
    if (_debugMode) {
      _debugLog('--- $scenarioName ---');
    }
  }

  static FairSplitCalculatorResults calculate(FairSplitInputs inputs) {
    _debugLogInputs(inputs);

    // Calculate 50/50 Split
    final fiftyFiftySplit = _calculate50Split(inputs);

    // Calculate % Split
    final percentageSplit = _calculatePercentagesplit(inputs);

    // Calculate EvenEdge Split
    final evenEdgeSplit = _calculateEvenEdgeSplit(inputs);

    return FairSplitCalculatorResults(
      fiftyFiftySplit: fiftyFiftySplit,
      percentageSplit: percentageSplit,
      evenEdgeSplit: evenEdgeSplit,
    );
  }

  static FairSplitResult _calculate50Split(FairSplitInputs inputs) {
    _debugLog('\n🔢 === 50/50 SPLIT CALCULATION ===');

    // Calculate both scenarios
    final jointBillsScenario = _calculate50SplitJointBills(inputs);
    final separateBillsScenario = _calculate50SplitSeparateBills(inputs);

    _debugLog('=== END 50/50 SPLIT ===\n');

    return FairSplitResult(
      title: '50/50 Split',
      jointBillsScenario: jointBillsScenario,
      separateBillsScenario: separateBillsScenario,
    );
  }

  static FairSplitScenario _calculate50SplitJointBills(FairSplitInputs inputs) {
    _debugLogScenario('JOINT BILLS (All bills treated as shared)');

    // Step 1: Add half of joint income to each partner's income
    final partner1TotalIncome =
        inputs.partner1Income + (inputs.jointIncome / 2);
    final partner2TotalIncome =
        inputs.partner2Income + (inputs.jointIncome / 2);

    // Step 2: Pool all outgoings and split 50/50
    final totalOutgoings =
        inputs.partner1Outgoings +
        inputs.partner2Outgoings +
        inputs.jointOutgoings;
    final halfTotalOutgoings = totalOutgoings / 2;

    _debugLogStep(
      'Steps 1-2',
      'Pool all bills and split 50/50',
      values: {
        'Partner 1 Total Income': partner1TotalIncome,
        'Partner 2 Total Income': partner2TotalIncome,
        'Total Outgoings': totalOutgoings,
        'Each Partner Pays': halfTotalOutgoings,
      },
    );

    // Step 3: Calculate remaining amounts
    final partner1Remaining = partner1TotalIncome - halfTotalOutgoings;
    final partner2Remaining = partner2TotalIncome - halfTotalOutgoings;

    _debugLogStep(
      'Step 3',
      'Calculate remaining amounts',
      values: {
        'Partner 1 Remaining': partner1Remaining,
        'Partner 2 Remaining': partner2Remaining,
      },
    );

    return FairSplitScenario(
      scenarioName: 'All Bills Joint',
      partner1Spend: '£${halfTotalOutgoings.toStringAsFixed(2)}',
      partner1Remaining: '£${partner1Remaining.toStringAsFixed(2)}',
      partner2Spend: '£${halfTotalOutgoings.toStringAsFixed(2)}',
      partner2Remaining: '£${partner2Remaining.toStringAsFixed(2)}',
    );
  }

  static FairSplitScenario _calculate50SplitSeparateBills(
    FairSplitInputs inputs,
  ) {
    _debugLogScenario('SEPARATE BILLS (Personal bills remain separate)');

    // Step 1: Add half of joint income to each partner's income
    final partner1TotalIncome =
        inputs.partner1Income + (inputs.jointIncome / 2);
    final partner2TotalIncome =
        inputs.partner2Income + (inputs.jointIncome / 2);

    // Step 2: Split only joint expenses 50/50, keep personal expenses separate
    final halfJointOutgoings = inputs.jointOutgoings / 2;
    final partner1TotalSpend = halfJointOutgoings + inputs.partner1Outgoings;
    final partner2TotalSpend = halfJointOutgoings + inputs.partner2Outgoings;

    _debugLogStep(
      'Steps 1-2',
      'Split joint bills 50/50, keep personal bills separate',
      values: {
        'Partner 1 Total Income': partner1TotalIncome,
        'Partner 2 Total Income': partner2TotalIncome,
        'Half Joint Outgoings': halfJointOutgoings,
        'Partner 1 Total Spend': partner1TotalSpend,
        'Partner 2 Total Spend': partner2TotalSpend,
      },
    );

    // Step 3: Calculate remaining amounts
    final partner1Remaining = partner1TotalIncome - partner1TotalSpend;
    final partner2Remaining = partner2TotalIncome - partner2TotalSpend;

    _debugLogStep(
      'Step 3',
      'Calculate remaining amounts',
      values: {
        'Partner 1 Remaining': partner1Remaining,
        'Partner 2 Remaining': partner2Remaining,
      },
    );

    return FairSplitScenario(
      scenarioName: 'Personal Bills Separate',
      partner1Spend: '£${partner1TotalSpend.toStringAsFixed(2)}',
      partner1Remaining: '£${partner1Remaining.toStringAsFixed(2)}',
      partner2Spend: '£${partner2TotalSpend.toStringAsFixed(2)}',
      partner2Remaining: '£${partner2Remaining.toStringAsFixed(2)}',
    );
  }

  static FairSplitResult _calculatePercentagesplit(FairSplitInputs inputs) {
    _debugLog('\n📊 === PERCENTAGE SPLIT CALCULATION ===');

    // Calculate both scenarios
    final jointBillsScenario = _calculatePercentageSplitJointBills(inputs);
    final separateBillsScenario = _calculatePercentageSplitSeparateBills(
      inputs,
    );

    _debugLog('=== END PERCENTAGE SPLIT ===\n');

    return FairSplitResult(
      title: '% Split',
      jointBillsScenario: jointBillsScenario,
      separateBillsScenario: separateBillsScenario,
    );
  }

  static FairSplitScenario _calculatePercentageSplitJointBills(
    FairSplitInputs inputs,
  ) {
    _debugLogScenario('JOINT BILLS (All bills treated as shared)');

    // Step 1: Add half of joint income to each partner's income
    final partner1TotalIncome =
        inputs.partner1Income + (inputs.jointIncome / 2);
    final partner2TotalIncome =
        inputs.partner2Income + (inputs.jointIncome / 2);

    // Step 2: Calculate percentages based on total income including joint
    final totalIncome = partner1TotalIncome + partner2TotalIncome;
    final partner1Percentage = (partner1TotalIncome / totalIncome) * 100;
    final partner2Percentage = (partner2TotalIncome / totalIncome) * 100;

    _debugLogStep(
      'Steps 1-2',
      'Calculate income percentages',
      values: {
        'Partner 1 Total Income': partner1TotalIncome,
        'Partner 2 Total Income': partner2TotalIncome,
        'Total Income': totalIncome,
        'Partner 1 Percentage': partner1Percentage,
        'Partner 2 Percentage': partner2Percentage,
      },
    );

    // Step 3: Pool all outgoings and split by percentage
    final totalOutgoings =
        inputs.partner1Outgoings +
        inputs.partner2Outgoings +
        inputs.jointOutgoings;
    final partner1Share = totalOutgoings * (partner1Percentage / 100);
    final partner2Share = totalOutgoings * (partner2Percentage / 100);

    _debugLogStep(
      'Step 3',
      'Split all bills by percentage',
      values: {
        'Total Outgoings': totalOutgoings,
        'Partner 1 Share': partner1Share,
        'Partner 2 Share': partner2Share,
      },
    );

    // Step 4: Calculate remaining amounts
    final partner1Remaining = partner1TotalIncome - partner1Share;
    final partner2Remaining = partner2TotalIncome - partner2Share;

    _debugLogStep(
      'Step 4',
      'Calculate remaining amounts',
      values: {
        'Partner 1 Remaining': partner1Remaining,
        'Partner 2 Remaining': partner2Remaining,
      },
    );

    return FairSplitScenario(
      scenarioName: 'All Bills Joint',
      partner1Spend: '£${partner1Share.toStringAsFixed(2)}',
      partner1Remaining: '£${partner1Remaining.toStringAsFixed(2)}',
      partner2Spend: '£${partner2Share.toStringAsFixed(2)}',
      partner2Remaining: '£${partner2Remaining.toStringAsFixed(2)}',
    );
  }

  static FairSplitScenario _calculatePercentageSplitSeparateBills(
    FairSplitInputs inputs,
  ) {
    _debugLogScenario('SEPARATE BILLS (Personal bills remain separate)');

    // Step 1: Add half of joint income to each partner's income
    final partner1TotalIncome =
        inputs.partner1Income + (inputs.jointIncome / 2);
    final partner2TotalIncome =
        inputs.partner2Income + (inputs.jointIncome / 2);

    // Step 2: Calculate percentages based on total income including joint
    final totalIncome = partner1TotalIncome + partner2TotalIncome;
    final partner1Percentage = (partner1TotalIncome / totalIncome) * 100;
    final partner2Percentage = (partner2TotalIncome / totalIncome) * 100;

    // Step 3: Split only joint expenses by percentage, keep personal expenses separate
    final partner1JointShare =
        inputs.jointOutgoings * (partner1Percentage / 100);
    final partner2JointShare =
        inputs.jointOutgoings * (partner2Percentage / 100);
    final partner1TotalSpend = partner1JointShare + inputs.partner1Outgoings;
    final partner2TotalSpend = partner2JointShare + inputs.partner2Outgoings;

    _debugLogStep(
      'Steps 1-3',
      'Split joint bills by percentage, keep personal bills separate',
      values: {
        'Partner 1 Total Income': partner1TotalIncome,
        'Partner 2 Total Income': partner2TotalIncome,
        'Partner 1 Percentage': partner1Percentage,
        'Partner 2 Percentage': partner2Percentage,
        'Partner 1 Joint Share': partner1JointShare,
        'Partner 2 Joint Share': partner2JointShare,
        'Partner 1 Total Spend': partner1TotalSpend,
        'Partner 2 Total Spend': partner2TotalSpend,
      },
    );

    // Step 4: Calculate remaining amounts
    final partner1Remaining = partner1TotalIncome - partner1TotalSpend;
    final partner2Remaining = partner2TotalIncome - partner2TotalSpend;

    _debugLogStep(
      'Step 4',
      'Calculate remaining amounts',
      values: {
        'Partner 1 Remaining': partner1Remaining,
        'Partner 2 Remaining': partner2Remaining,
      },
    );

    return FairSplitScenario(
      scenarioName: 'Personal Bills Separate',
      partner1Spend: '£${partner1TotalSpend.toStringAsFixed(2)}',
      partner1Remaining: '£${partner1Remaining.toStringAsFixed(2)}',
      partner2Spend: '£${partner2TotalSpend.toStringAsFixed(2)}',
      partner2Remaining: '£${partner2Remaining.toStringAsFixed(2)}',
    );
  }

  static FairSplitResult _calculateEvenEdgeSplit(FairSplitInputs inputs) {
    _debugLog('\n⚖️ === EVENEDGE SPLIT CALCULATION ===');

    // Calculate both scenarios
    final jointBillsScenario = _calculateEvenEdgeSplitJointBills(inputs);
    final separateBillsScenario = _calculateEvenEdgeSplitSeparateBills(inputs);

    _debugLog('=== END EVENEDGE SPLIT ===\n');

    return FairSplitResult(
      title: 'EvenEdge',
      jointBillsScenario: jointBillsScenario,
      separateBillsScenario: separateBillsScenario,
    );
  }

  static FairSplitScenario _calculateEvenEdgeSplitJointBills(
    FairSplitInputs inputs,
  ) {
    _debugLogScenario('JOINT BILLS (All bills treated as shared)');

    // Step 1: Calculate total income and individual totals
    final totalIncome =
        inputs.partner1Income + inputs.partner2Income + inputs.jointIncome;
    final partner1TotalIncome =
        inputs.partner1Income + (inputs.jointIncome / 2);
    final partner2TotalIncome =
        inputs.partner2Income + (inputs.jointIncome / 2);

    // Step 2: Calculate total outgoings and equal remaining amount
    final totalOutgoings =
        inputs.partner1Outgoings +
        inputs.partner2Outgoings +
        inputs.jointOutgoings;
    final totalRemainingAfterBills = totalIncome - totalOutgoings;
    final equalRemainingPerPartner = totalRemainingAfterBills / 2;

    _debugLogStep(
      'Steps 1-2',
      'Pool everything for equal remaining amounts',
      values: {
        'Total Income': totalIncome,
        'Partner 1 Total Income': partner1TotalIncome,
        'Partner 2 Total Income': partner2TotalIncome,
        'Total Outgoings': totalOutgoings,
        'Equal Remaining Per Partner': equalRemainingPerPartner,
      },
    );

    // Step 3: Calculate each partner's spend to achieve equal remaining
    final partner1Spend = partner1TotalIncome - equalRemainingPerPartner;
    final partner2Spend = partner2TotalIncome - equalRemainingPerPartner;

    _debugLogStep(
      'Step 3',
      'Calculate spend for equal remaining',
      values: {
        'Partner 1 Spend': partner1Spend,
        'Partner 2 Spend': partner2Spend,
      },
    );

    return FairSplitScenario(
      scenarioName: 'All Bills Joint',
      partner1Spend: '£${partner1Spend.toStringAsFixed(2)}',
      partner1Remaining: '£${equalRemainingPerPartner.toStringAsFixed(2)}',
      partner2Spend: '£${partner2Spend.toStringAsFixed(2)}',
      partner2Remaining: '£${equalRemainingPerPartner.toStringAsFixed(2)}',
    );
  }

  static FairSplitScenario _calculateEvenEdgeSplitSeparateBills(FairSplitInputs inputs) {
    _debugLogScenario('SEPARATE BILLS (Personal bills remain separate)');
    
    // Step 1: Calculate individual incomes (including joint income share)
    final partner1TotalIncome = inputs.partner1Income + (inputs.jointIncome / 2);
    final partner2TotalIncome = inputs.partner2Income + (inputs.jointIncome / 2);
    final totalIncome = partner1TotalIncome + partner2TotalIncome;
    
    _debugLogStep('Step 1', 'Calculate total income for each partner', values: {
      'Partner 1 Total Income': partner1TotalIncome,
      'Partner 2 Total Income': partner2TotalIncome,
      'Total Household Income': totalIncome,
    });

    // Step 2: Calculate equal remaining amount after JOINT bills only (ignore personal bills for now)
    final totalRemainingAfterJointBills = totalIncome - inputs.jointOutgoings;
    final equalRemainingAfterJointBills = totalRemainingAfterJointBills / 2;
    
    _debugLogStep('Step 2', 'Calculate equal remaining after JOINT bills only', values: {
      'Joint Bills Only': inputs.jointOutgoings,
      'Total Remaining After Joint Bills': totalRemainingAfterJointBills,
      'Equal Remaining After Joint Bills': equalRemainingAfterJointBills,
    });

    // Step 3: Calculate how much each partner contributes to joint bills to achieve equal remaining after joint bills
    final partner1JointContribution = partner1TotalIncome - equalRemainingAfterJointBills;
    final partner2JointContribution = partner2TotalIncome - equalRemainingAfterJointBills;
    
    _debugLogStep('Step 3', 'Calculate joint bill contributions for equal remaining after joint bills', values: {
      'Partner 1 Joint Contribution': partner1JointContribution,
      'Partner 2 Joint Contribution': partner2JointContribution,
      'Total Joint Contributions': partner1JointContribution + partner2JointContribution,
      'Should Equal Joint Bills': inputs.jointOutgoings,
      'Difference': (partner1JointContribution + partner2JointContribution) - inputs.jointOutgoings,
    });

    // Step 4: Now each partner pays their own personal bills from their remaining amount
    final partner1AfterJointBills = partner1TotalIncome - partner1JointContribution;
    final partner2AfterJointBills = partner2TotalIncome - partner2JointContribution;
    final partner1FinalRemaining = partner1AfterJointBills - inputs.partner1Outgoings;
    final partner2FinalRemaining = partner2AfterJointBills - inputs.partner2Outgoings;
    
    _debugLogStep('Step 4', 'Each partner pays their own personal bills (separate)', values: {
      'Partner 1 After Joint Bills': partner1AfterJointBills,
      'Partner 2 After Joint Bills': partner2AfterJointBills,
      'Partner 1 Personal Bills': inputs.partner1Outgoings,
      'Partner 2 Personal Bills': inputs.partner2Outgoings,
      'Partner 1 Final Remaining': partner1FinalRemaining,
      'Partner 2 Final Remaining': partner2FinalRemaining,
    });

    // Step 5: Calculate total spend for display
    final partner1TotalSpend = partner1JointContribution + inputs.partner1Outgoings;
    final partner2TotalSpend = partner2JointContribution + inputs.partner2Outgoings;
    
    _debugLogStep('Step 5', 'Calculate total spend (joint contribution + personal bills)', values: {
      'Partner 1: Joint Contribution': partner1JointContribution,
      'Partner 1: Personal Bills': inputs.partner1Outgoings,
      'Partner 1: Total Spend': partner1TotalSpend,
      'Partner 2: Joint Contribution': partner2JointContribution,
      'Partner 2: Personal Bills': inputs.partner2Outgoings,
      'Partner 2: Total Spend': partner2TotalSpend,
    });

    // VERIFICATION: Double-check the math
    final partner1CalculatedRemaining = partner1TotalIncome - partner1TotalSpend;
    final partner2CalculatedRemaining = partner2TotalIncome - partner2TotalSpend;
    
    _debugLogStep('VERIFICATION', 'Double-check remaining amounts', values: {
      'Partner 1 Calculated Remaining': partner1CalculatedRemaining,
      'Partner 2 Calculated Remaining': partner2CalculatedRemaining,
      'Partner 1 Final Remaining': partner1FinalRemaining,
      'Partner 2 Final Remaining': partner2FinalRemaining,
      'Amounts Should Match': partner1CalculatedRemaining == partner1FinalRemaining && partner2CalculatedRemaining == partner2FinalRemaining ? 1.0 : 0.0,
    });

    return FairSplitScenario(
      scenarioName: 'Personal Bills Separate',
      partner1Spend: '£${partner1TotalSpend.toStringAsFixed(2)}',
      partner1Remaining: '£${partner1FinalRemaining.toStringAsFixed(2)}',
      partner2Spend: '£${partner2TotalSpend.toStringAsFixed(2)}',
      partner2Remaining: '£${partner2FinalRemaining.toStringAsFixed(2)}',
    );
  }
}
