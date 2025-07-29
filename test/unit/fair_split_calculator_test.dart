import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/utils/fair_split_calculator.dart';

void main() {
  group('FairSplitCalculator', () {
    group('Base Cases', () {
      test('all values are zero', () {
        final inputs = FairSplitInputs(
          partner1Income: 0,
          partner2Income: 0,
          jointIncome: 0,
          partner1Outgoings: 0,
          partner2Outgoings: 0,
          jointOutgoings: 0,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // All splits should result in zero spend and zero remaining
        _verifyZeroResults(results.fiftyFiftySplit);
        _verifyZeroResults(results.percentageSplit);
        _verifyZeroResults(results.evenEdgeSplit);
      });

      test('all values are the same non-zero value', () {
        final inputs = FairSplitInputs(
          partner1Income: 100,
          partner2Income: 100,
          jointIncome: 100,
          partner1Outgoings: 100,
          partner2Outgoings: 100,
          jointOutgoings: 100,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // 50/50 Split Tests
        expect(results.fiftyFiftySplit.title, '50/50 Split');

        // Joint Bills: Total income = 300, total outgoings = 300, split 50/50
        // Each partner gets 150 income, pays 150 outgoings, remaining = 0
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
          '£150.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Remaining,
          '£0.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Spend,
          '£150.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Remaining,
          '£0.00',
        );

        // Separate Bills: Each partner gets 150 income, pays 50 joint + 100 personal = 150
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner1Spend,
          '£150.00',
        );
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner1Remaining,
          '£0.00',
        );
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner2Spend,
          '£150.00',
        );
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner2Remaining,
          '£0.00',
        );

        // Percentage Split Tests (should be same as 50/50 when incomes are equal)
        expect(results.percentageSplit.title, '% Split');
        expect(
          results.percentageSplit.jointBillsScenario.partner1Spend,
          '£150.00',
        );
        expect(
          results.percentageSplit.jointBillsScenario.partner1Remaining,
          '£0.00',
        );
        expect(
          results.percentageSplit.separateBillsScenario.partner1Spend,
          '£150.00',
        );
        expect(
          results.percentageSplit.separateBillsScenario.partner1Remaining,
          '£0.00',
        );

        // EvenEdge Split Tests (should result in equal remaining amounts)
        expect(results.evenEdgeSplit.title, 'EvenEdge');
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
        );
      });
    });

    group('Equal Income, Different Spending', () {
      test('partners earn same but spend differently', () {
        final inputs = FairSplitInputs(
          partner1Income: 2000,
          partner2Income: 2000,
          jointIncome: 0,
          partner1Outgoings: 500,
          partner2Outgoings: 1000,
          jointOutgoings: 800,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // 50/50 Split - Joint Bills
        // Total outgoings = 2300, each pays 1150
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
          '£1150.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Remaining,
          '£850.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Spend,
          '£1150.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Remaining,
          '£850.00',
        );

        // 50/50 Split - Separate Bills
        // Each pays 400 joint + their personal bills
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner1Spend,
          '£900.00',
        ); // 400 + 500
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner1Remaining,
          '£1100.00',
        );
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner2Spend,
          '£1400.00',
        ); // 400 + 1000
        expect(
          results.fiftyFiftySplit.separateBillsScenario.partner2Remaining,
          '£600.00',
        );

        // Percentage Split should be same as 50/50 when incomes are equal
        expect(
          results.percentageSplit.jointBillsScenario.partner1Spend,
          '£1150.00',
        );
        expect(
          results.percentageSplit.separateBillsScenario.partner1Spend,
          '£900.00',
        );

        // EvenEdge Split - Joint Bills should result in equal remaining
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          '£850.00',
        );
      });
    });

    group('Different Incomes', () {
      test('partners earn differently', () {
        final inputs = FairSplitInputs(
          partner1Income: 3000,
          partner2Income: 2000,
          jointIncome: 500,
          partner1Outgoings: 600,
          partner2Outgoings: 400,
          jointOutgoings: 1000,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // Partner 1 total income: 3000 + 250 = 3250
        // Partner 2 total income: 2000 + 250 = 2250
        // Total income: 5500

        // 50/50 Split - Joint Bills
        // Total outgoings = 2000, each pays 1000
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
          '£1000.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Remaining,
          '£2250.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Spend,
          '£1000.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Remaining,
          '£1250.00',
        );

        // Percentage Split - Joint Bills
        // Partner 1: 59.09%, Partner 2: 40.91%
        expect(
          results.percentageSplit.jointBillsScenario.partner1Spend,
          '£1181.82',
        );
        expect(
          results.percentageSplit.jointBillsScenario.partner1Remaining,
          '£2068.18',
        );
        expect(
          results.percentageSplit.jointBillsScenario.partner2Spend,
          '£818.18',
        );
        expect(
          results.percentageSplit.jointBillsScenario.partner2Remaining,
          '£1431.82',
        );

        // EvenEdge Split - Joint Bills should result in equal remaining
        // Total remaining after all bills: 5500 - 2000 = 3500
        // Each should have 1750 remaining
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          '£1750.00',
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
          '£1750.00',
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Spend,
          '£1500.00',
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner2Spend,
          '£500.00',
        );
      });

      test('one partner earns significantly more', () {
        final inputs = FairSplitInputs(
          partner1Income: 5000,
          partner2Income: 1000,
          jointIncome: 0,
          partner1Outgoings: 800,
          partner2Outgoings: 300,
          jointOutgoings: 1200,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // Partner 1: 83.33% of total income
        // Partner 2: 16.67% of total income

        // Percentage Split - Joint Bills
        expect(
          results.percentageSplit.jointBillsScenario.partner1Spend,
          '£1916.67',
        );
        expect(
          results.percentageSplit.jointBillsScenario.partner2Spend,
          '£383.33',
        );

        // EvenEdge Split - should equalize remaining amounts
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          '£1850.00',
        );

        // In extreme cases, EvenEdge can result in negative spend (partner receives money)
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner2Spend,
          '£-850.00',
        );
      });
    });

    group('Edge Cases - Negative Remaining', () {
      test('one partner would have negative remaining in 50/50 split', () {
        final inputs = FairSplitInputs(
          partner1Income: 500, // Low income
          partner2Income: 3000, // High income
          jointIncome: 0,
          partner1Outgoings: 100,
          partner2Outgoings: 200,
          jointOutgoings: 2000, // High joint expenses
        );

        final results = FairSplitCalculator.calculate(inputs);

        // 50/50 Split - Joint Bills
        // Total outgoings = 2300, each should pay 1150
        // Partner 1 income = 500, would have -650 remaining
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
          '£1150.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Remaining,
          '£-650.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Remaining,
          '£1850.00',
        );

        // EvenEdge Split handles this better
        // Total income = 3500, total outgoings = 2300, remaining = 1200
        // Each should have 600 remaining
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          '£600.00',
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
          '£600.00',
        );

        // Partner 1 has negative spend (receives money)
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Spend,
          '£-100.00',
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner2Spend,
          '£2400.00',
        );
      });

      test('both partners would have negative remaining', () {
        final inputs = FairSplitInputs(
          partner1Income: 800,
          partner2Income: 700,
          jointIncome: 0,
          partner1Outgoings: 400,
          partner2Outgoings: 300,
          jointOutgoings: 1200,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // Total income = 1500, total outgoings = 1900
        // Deficit of 400

        // 50/50 Split - Joint Bills
        // Each pays 950, both have negative remaining
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner1Remaining,
          '£-150.00',
        );
        expect(
          results.fiftyFiftySplit.jointBillsScenario.partner2Remaining,
          '£-250.00',
        );

        // EvenEdge Split - both should have equal negative remaining
        // Each should have -200 remaining
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          '£-200.00',
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
          '£-200.00',
        );
      });
    });

    group('Complex Scenarios with Joint Income', () {
      test('significant joint income affects calculations', () {
        final inputs = FairSplitInputs(
          partner1Income: 2000,
          partner2Income: 1500,
          jointIncome: 1000, // Significant joint income
          partner1Outgoings: 500,
          partner2Outgoings: 400,
          jointOutgoings: 800,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // Partner 1 total: 2000 + 500 = 2500
        // Partner 2 total: 1500 + 500 = 2000
        // Total: 4500
        // Partner 1: 55.56%, Partner 2: 44.44%

        // Verify percentage split considers joint income
        expect(
          results.percentageSplit.jointBillsScenario.partner1Spend,
          '£944.44',
        );
        expect(
          results.percentageSplit.jointBillsScenario.partner2Spend,
          '£755.56',
        );

        // EvenEdge should still result in equal remaining
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          results.evenEdgeSplit.jointBillsScenario.partner2Remaining,
        );
        expect(
          results.evenEdgeSplit.jointBillsScenario.partner1Remaining,
          '£1400.00',
        );
      });
    });

    group('EvenEdge Separate Bills Specific Tests', () {
      test(
        'evenEdge separate bills maintains equal remaining after joint, then personal bills',
        () {
          final inputs = FairSplitInputs(
            partner1Income: 3000,
            partner2Income: 2000,
            jointIncome: 0,
            partner1Outgoings: 800, // Higher personal bills
            partner2Outgoings: 200, // Lower personal bills
            jointOutgoings: 1000,
          );

          final results = FairSplitCalculator.calculate(inputs);

          // In EvenEdge separate bills:
          // 1. Split joint bills to achieve equal remaining after joint bills
          // 2. Each partner then pays their own personal bills
          // Final remaining amounts will NOT be equal due to different personal bills

          expect(
            results.evenEdgeSplit.separateBillsScenario.partner1Remaining,
            '£1200.00',
          );
          expect(
            results.evenEdgeSplit.separateBillsScenario.partner2Remaining,
            '£1800.00',
          );

          // The difference equals the difference in personal bills (800 - 200 = 600)
          final partner1Remaining = double.parse(
            results.evenEdgeSplit.separateBillsScenario.partner1Remaining
                .substring(1),
          );
          final partner2Remaining = double.parse(
            results.evenEdgeSplit.separateBillsScenario.partner2Remaining
                .substring(1),
          );
          expect(partner2Remaining - partner1Remaining, closeTo(600, 0.1));
        },
      );
    });

    group('Calculation Integrity', () {
      test('all splits should maintain mathematical consistency', () {
        final inputs = FairSplitInputs(
          partner1Income: 2500,
          partner2Income: 1800,
          jointIncome: 400,
          partner1Outgoings: 700,
          partner2Outgoings: 500,
          jointOutgoings: 900,
        );

        final results = FairSplitCalculator.calculate(inputs);

        // Total income should be conserved across all calculations
        final totalIncome =
            inputs.partner1Income + inputs.partner2Income + inputs.jointIncome;

        // For joint bills scenarios, total spend + total remaining should equal total income
        _verifyIncomeConservation(
          results.fiftyFiftySplit.jointBillsScenario,
          totalIncome,
        );
        _verifyIncomeConservation(
          results.percentageSplit.jointBillsScenario,
          totalIncome,
        );
        _verifyIncomeConservation(
          results.evenEdgeSplit.jointBillsScenario,
          totalIncome,
        );

        // For separate bills scenarios, same principle applies
        _verifyIncomeConservation(
          results.fiftyFiftySplit.separateBillsScenario,
          totalIncome,
        );
        _verifyIncomeConservation(
          results.percentageSplit.separateBillsScenario,
          totalIncome,
        );
        _verifyIncomeConservation(
          results.evenEdgeSplit.separateBillsScenario,
          totalIncome,
        );
      });
    });
  });
}

void _verifyZeroResults(FairSplitResult result) {
  expect(result.jointBillsScenario.partner1Spend, '£0.00');
  expect(result.jointBillsScenario.partner1Remaining, '£0.00');
  expect(result.jointBillsScenario.partner2Spend, '£0.00');
  expect(result.jointBillsScenario.partner2Remaining, '£0.00');

  expect(result.separateBillsScenario.partner1Spend, '£0.00');
  expect(result.separateBillsScenario.partner1Remaining, '£0.00');
  expect(result.separateBillsScenario.partner2Spend, '£0.00');
  expect(result.separateBillsScenario.partner2Remaining, '£0.00');
}

void _verifyIncomeConservation(FairSplitScenario scenario, double totalIncome) {
  // Helper function to parse currency strings that may be negative
  double parseCurrency(String value) {
    if (value.startsWith('£-')) {
      return -double.parse(value.substring(2));
    } else if (value.startsWith('£')) {
      return double.parse(value.substring(1));
    }
    return double.parse(value);
  }

  final partner1Spend = parseCurrency(scenario.partner1Spend);
  final partner1Remaining = parseCurrency(scenario.partner1Remaining);
  final partner2Spend = parseCurrency(scenario.partner2Spend);
  final partner2Remaining = parseCurrency(scenario.partner2Remaining);

  final totalSpend = partner1Spend + partner2Spend;
  final totalRemaining = partner1Remaining + partner2Remaining;

  // Total spend + total remaining should equal total income (within rounding tolerance)
  expect(totalSpend + totalRemaining, closeTo(totalIncome, 0.01));
}
