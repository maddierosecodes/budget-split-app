import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/utils/fair_split_calculator.dart';
import 'package:evenedge/widgets/common/household_info_box.dart';
import 'package:evenedge/widgets/common/result_box.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_results_screen.dart';

void main() {
  group('Fair Split Calculator Widget Tests', () {
    // Test data following the same progression as unit tests
    final testInputsBasic = FairSplitInputs(
      partner1Income: 2000,
      partner2Income: 2000,
      jointIncome: 0,
      partner1Outgoings: 500,
      partner2Outgoings: 1000,
      jointOutgoings: 800,
    );

    final testInputsComplex = FairSplitInputs(
      partner1Income: 3000,
      partner2Income: 2000,
      jointIncome: 500,
      partner1Outgoings: 600,
      partner2Outgoings: 400,
      jointOutgoings: 1000,
    );

    final testInputsExtreme = FairSplitInputs(
      partner1Income: 5000,
      partner2Income: 1000,
      jointIncome: 0,
      partner1Outgoings: 800,
      partner2Outgoings: 300,
      jointOutgoings: 1200,
    );

    final testInputsZero = FairSplitInputs(
      partner1Income: 0,
      partner2Income: 0,
      jointIncome: 0,
      partner1Outgoings: 0,
      partner2Outgoings: 0,
      jointOutgoings: 0,
    );

    group('HouseholdInfoBox Widget Tests', () {
      testWidgets('displays household summary with basic equal incomes', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HouseholdInfoBox(
                partner1Income: testInputsBasic.partner1Income,
                partner2Income: testInputsBasic.partner2Income,
                jointIncome: testInputsBasic.jointIncome,
                partner1Outgoings: testInputsBasic.partner1Outgoings,
                partner2Outgoings: testInputsBasic.partner2Outgoings,
                jointOutgoings: testInputsBasic.jointOutgoings,
              ),
            ),
          ),
        );

        // Check household summary header
        expect(find.text('Household Summary'), findsOneWidget);

        // Check total household income
        expect(find.text('Total Household Income'), findsOneWidget);
        expect(find.text('£4000.00'), findsOneWidget); // 2000 + 2000 + 0

        // Check total household bills
        expect(find.text('Total Household Bills'), findsOneWidget);
        expect(find.text('£2300.00'), findsOneWidget); // 500 + 1000 + 800

        // Check income distribution section
        expect(find.text('Income Distribution'), findsOneWidget);

        // Check partner percentages (equal income = 50% each)
        expect(find.text('Partner 1'), findsOneWidget);
        expect(
          find.text('50.0%'),
          findsNWidgets(2),
        ); // Should find 2 instances (one for each partner)
        expect(
          find.text('£2000.00'),
          findsNWidgets(2),
        ); // Each partner's total income

        expect(find.text('Partner 2'), findsOneWidget);
      });

      testWidgets(
        'displays correct percentages with different incomes and joint income',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: HouseholdInfoBox(
                  partner1Income: testInputsComplex.partner1Income,
                  partner2Income: testInputsComplex.partner2Income,
                  jointIncome: testInputsComplex.jointIncome,
                  partner1Outgoings: testInputsComplex.partner1Outgoings,
                  partner2Outgoings: testInputsComplex.partner2Outgoings,
                  jointOutgoings: testInputsComplex.jointOutgoings,
                ),
              ),
            ),
          );

          // Check total household income
          expect(find.text('£5500.00'), findsOneWidget); // 3000 + 2000 + 500

          // Check total household bills
          expect(find.text('£2000.00'), findsOneWidget); // 600 + 400 + 1000

          // Check partner 1: 3000 + 250 = 3250 (59.1% of 5500)
          expect(find.text('59.1%'), findsOneWidget);
          expect(find.text('£3250.00'), findsOneWidget);

          // Check partner 2: 2000 + 250 = 2250 (40.9% of 5500)
          expect(find.text('40.9%'), findsOneWidget);
          expect(find.text('£2250.00'), findsOneWidget);
        },
      );

      testWidgets('handles extreme income disparity correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HouseholdInfoBox(
                partner1Income: testInputsExtreme.partner1Income,
                partner2Income: testInputsExtreme.partner2Income,
                jointIncome: testInputsExtreme.jointIncome,
                partner1Outgoings: testInputsExtreme.partner1Outgoings,
                partner2Outgoings: testInputsExtreme.partner2Outgoings,
                jointOutgoings: testInputsExtreme.jointOutgoings,
              ),
            ),
          ),
        );

        // Check extreme disparity percentages
        expect(find.text('83.3%'), findsOneWidget); // Partner 1: high earner
        expect(find.text('16.7%'), findsOneWidget); // Partner 2: low earner

        expect(find.text('£5000.00'), findsOneWidget); // Partner 1 income
        expect(find.text('£1000.00'), findsOneWidget); // Partner 2 income
      });

      testWidgets('handles zero values without errors', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HouseholdInfoBox(
                partner1Income: testInputsZero.partner1Income,
                partner2Income: testInputsZero.partner2Income,
                jointIncome: testInputsZero.jointIncome,
                partner1Outgoings: testInputsZero.partner1Outgoings,
                partner2Outgoings: testInputsZero.partner2Outgoings,
                jointOutgoings: testInputsZero.jointOutgoings,
              ),
            ),
          ),
        );

        // Check zero values display correctly
        expect(
          find.text('£0.00'),
          findsNWidgets(4),
        ); // Total income, total bills, partner 1 & 2 amounts
        expect(
          find.text('0.0%'),
          findsNWidgets(2),
        ); // Both partner percentages should be 0
      });
    });

    group('ResultBox Widget Tests', () {
      testWidgets('displays 50/50 split results correctly', (tester) async {
        final results = FairSplitCalculator.calculate(testInputsBasic);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResultBox(
                title: results.fiftyFiftySplit.title,
                jointBillsScenarioName:
                    results.fiftyFiftySplit.jointBillsScenario.scenarioName,
                jointPartner1Spend:
                    results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
                jointPartner1Remaining: results
                    .fiftyFiftySplit
                    .jointBillsScenario
                    .partner1Remaining,
                jointPartner2Spend:
                    results.fiftyFiftySplit.jointBillsScenario.partner2Spend,
                jointPartner2Remaining: results
                    .fiftyFiftySplit
                    .jointBillsScenario
                    .partner2Remaining,
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
            ),
          ),
        );

        // Check title
        expect(find.text('50/50 Split'), findsOneWidget);

        // Check scenario names
        expect(find.text('All Bills Joint'), findsOneWidget);
        expect(find.text('Personal Bills Separate'), findsOneWidget);

        // Check joint bills scenario values
        expect(find.text('Partner 1 Spend: £1150.00'), findsOneWidget);
        expect(find.text('Partner 1 Remaining: £850.00'), findsOneWidget);
        expect(find.text('Partner 2 Spend: £1150.00'), findsOneWidget);
        expect(find.text('Partner 2 Remaining: £850.00'), findsOneWidget);

        // Check separate bills scenario values
        expect(find.text('Partner 1 Spend: £900.00'), findsOneWidget);
        expect(find.text('Partner 1 Remaining: £1100.00'), findsOneWidget);
        expect(find.text('Partner 2 Spend: £1400.00'), findsOneWidget);
        expect(find.text('Partner 2 Remaining: £600.00'), findsOneWidget);

        // Check free income distribution percentages appear
        expect(
          find.text('Free Income Distribution'),
          findsNWidgets(2),
        ); // One for each scenario
      });

      testWidgets('displays percentage split results with different incomes', (
        tester,
      ) async {
        final results = FairSplitCalculator.calculate(testInputsComplex);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResultBox(
                title: results.percentageSplit.title,
                jointBillsScenarioName:
                    results.percentageSplit.jointBillsScenario.scenarioName,
                jointPartner1Spend:
                    results.percentageSplit.jointBillsScenario.partner1Spend,
                jointPartner1Remaining: results
                    .percentageSplit
                    .jointBillsScenario
                    .partner1Remaining,
                jointPartner2Spend:
                    results.percentageSplit.jointBillsScenario.partner2Spend,
                jointPartner2Remaining: results
                    .percentageSplit
                    .jointBillsScenario
                    .partner2Remaining,
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
            ),
          ),
        );

        // Check title
        expect(find.text('% Split'), findsOneWidget);

        // Check that higher earner pays more in percentage split
        expect(
          find.text('Partner 1 Spend: £1181.82'),
          findsOneWidget,
        ); // Higher earner pays more
        expect(
          find.text('Partner 2 Spend: £818.18'),
          findsOneWidget,
        ); // Lower earner pays less
      });

      testWidgets(
        'displays EvenEdge split results with equal remaining amounts',
        (tester) async {
          final results = FairSplitCalculator.calculate(testInputsComplex);

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: ResultBox(
                  title: results.evenEdgeSplit.title,
                  jointBillsScenarioName:
                      results.evenEdgeSplit.jointBillsScenario.scenarioName,
                  jointPartner1Spend:
                      results.evenEdgeSplit.jointBillsScenario.partner1Spend,
                  jointPartner1Remaining: results
                      .evenEdgeSplit
                      .jointBillsScenario
                      .partner1Remaining,
                  jointPartner2Spend:
                      results.evenEdgeSplit.jointBillsScenario.partner2Spend,
                  jointPartner2Remaining: results
                      .evenEdgeSplit
                      .jointBillsScenario
                      .partner2Remaining,
                  separateBillsScenarioName:
                      results.evenEdgeSplit.separateBillsScenario.scenarioName,
                  separatePartner1Spend:
                      results.evenEdgeSplit.separateBillsScenario.partner1Spend,
                  separatePartner1Remaining: results
                      .evenEdgeSplit
                      .separateBillsScenario
                      .partner1Remaining,
                  separatePartner2Spend:
                      results.evenEdgeSplit.separateBillsScenario.partner2Spend,
                  separatePartner2Remaining: results
                      .evenEdgeSplit
                      .separateBillsScenario
                      .partner2Remaining,
                ),
              ),
            ),
          );

          // Check title
          expect(find.text('EvenEdge'), findsOneWidget);

          // Check equal remaining amounts in joint bills scenario
          expect(find.text('Partner 1 Remaining: £1750.00'), findsOneWidget);
          expect(find.text('Partner 2 Remaining: £1750.00'), findsOneWidget);

          // Check that spend amounts are different to achieve equal remaining
          expect(
            find.text('Partner 1 Spend: £1500.00'),
            findsOneWidget,
          ); // Higher earner pays more
          expect(
            find.text('Partner 2 Spend: £500.00'),
            findsOneWidget,
          ); // Lower earner pays less
        },
      );

      testWidgets('handles extreme scenarios with negative spend correctly', (
        tester,
      ) async {
        final results = FairSplitCalculator.calculate(testInputsExtreme);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResultBox(
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
                separatePartner1Remaining: results
                    .evenEdgeSplit
                    .separateBillsScenario
                    .partner1Remaining,
                separatePartner2Spend:
                    results.evenEdgeSplit.separateBillsScenario.partner2Spend,
                separatePartner2Remaining: results
                    .evenEdgeSplit
                    .separateBillsScenario
                    .partner2Remaining,
              ),
            ),
          ),
        );

        // Check that negative spend is displayed correctly (partner receives money)
        expect(find.text('Partner 2 Spend: £-850.00'), findsOneWidget);

        // Check equal remaining amounts despite extreme income disparity
        expect(find.text('Partner 1 Remaining: £1850.00'), findsOneWidget);
        expect(find.text('Partner 2 Remaining: £1850.00'), findsOneWidget);
      });

      testWidgets('calculates and displays free income percentages correctly', (
        tester,
      ) async {
        final results = FairSplitCalculator.calculate(testInputsBasic);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResultBox(
                title: results.fiftyFiftySplit.title,
                jointBillsScenarioName:
                    results.fiftyFiftySplit.jointBillsScenario.scenarioName,
                jointPartner1Spend:
                    results.fiftyFiftySplit.jointBillsScenario.partner1Spend,
                jointPartner1Remaining: results
                    .fiftyFiftySplit
                    .jointBillsScenario
                    .partner1Remaining,
                jointPartner2Spend:
                    results.fiftyFiftySplit.jointBillsScenario.partner2Spend,
                jointPartner2Remaining: results
                    .fiftyFiftySplit
                    .jointBillsScenario
                    .partner2Remaining,
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
            ),
          ),
        );

        // Wait for the widget to render
        await tester.pumpAndSettle();

        // Check that free income percentages are displayed
        // Joint scenario: both have £850 remaining = 50% each
        // Separate scenario: P1 has £1100, P2 has £600 = 64.7% and 35.3%
        final percentageTexts = tester
            .widgetList(find.byType(Text))
            .map((widget) => (widget as Text).data)
            .where((text) => text?.contains('%') == true && text != '50.0%')
            .toList();

        expect(percentageTexts.isNotEmpty, true);
      });
    });

    group('FairSplitResultsScreen Widget Tests', () {
      testWidgets('displays complete results screen with all components', (
        tester,
      ) async {
        final results = FairSplitCalculator.calculate(testInputsComplex);

        await tester.pumpWidget(
          MaterialApp(
            home: FairSplitResultsScreen(
              results: results,
              inputs: testInputsComplex,
            ),
          ),
        );

        // Check app bar
        expect(find.text('Fair Split Results'), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);

        // Check household info box is present
        expect(find.byType(HouseholdInfoBox), findsOneWidget);

        // Check all three result boxes are present
        expect(find.byType(ResultBox), findsNWidgets(3));

        // Check all split method titles
        expect(find.text('50/50 Split'), findsOneWidget);
        expect(find.text('% Split'), findsOneWidget);
        expect(find.text('EvenEdge'), findsOneWidget);

        // Check scrollable layout
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('displays all scenario information correctly', (
        tester,
      ) async {
        final results = FairSplitCalculator.calculate(testInputsComplex);

        await tester.pumpWidget(
          MaterialApp(
            home: FairSplitResultsScreen(
              results: results,
              inputs: testInputsComplex,
            ),
          ),
        );

        // Check that both scenario types are displayed for each split method
        expect(
          find.text('All Bills Joint'),
          findsNWidgets(3),
        ); // One for each split method
        expect(
          find.text('Personal Bills Separate'),
          findsNWidgets(3),
        ); // One for each split method

        // Check that free income distribution sections are present
        expect(
          find.text('Free Income Distribution'),
          findsNWidgets(6),
        ); // Two per split method (3 methods × 2 scenarios)
      });

      testWidgets('handles edge case with zero values', (tester) async {
        final results = FairSplitCalculator.calculate(testInputsZero);

        await tester.pumpWidget(
          MaterialApp(
            home: FairSplitResultsScreen(
              results: results,
              inputs: testInputsZero,
            ),
          ),
        );

        // Should render without errors
        expect(find.byType(FairSplitResultsScreen), findsOneWidget);
        expect(
          find.text('£0.00'),
          findsWidgets,
        ); // Multiple zero values should be displayed
      });

      testWidgets('layout and spacing are consistent', (tester) async {
        final results = FairSplitCalculator.calculate(testInputsBasic);

        await tester.pumpWidget(
          MaterialApp(
            home: FairSplitResultsScreen(
              results: results,
              inputs: testInputsBasic,
            ),
          ),
        );

        // Check proper spacing between components
        final sizedBoxes = find.byType(SizedBox);
        expect(sizedBoxes, findsWidgets);

        // Check padding is applied
        final paddedContainers = find.byType(Padding);
        expect(paddedContainers, findsWidgets);

        // Verify the column layout
        expect(find.byType(Column), findsWidgets);
      });

      testWidgets('all partner information is clearly labeled', (tester) async {
        final results = FairSplitCalculator.calculate(testInputsComplex);

        await tester.pumpWidget(
          MaterialApp(
            home: FairSplitResultsScreen(
              results: results,
              inputs: testInputsComplex,
            ),
          ),
        );

        // Check partner labels appear consistently
        expect(find.text('Partner 1'), findsWidgets);
        expect(find.text('Partner 2'), findsWidgets);

        // Check spend and remaining labels
        final spendTexts = tester
            .widgetList(find.byType(Text))
            .map((widget) => (widget as Text).data)
            .where((text) => text?.contains('Spend:') == true)
            .toList();
        expect(spendTexts.length, greaterThan(0));

        final remainingTexts = tester
            .widgetList(find.byType(Text))
            .map((widget) => (widget as Text).data)
            .where((text) => text?.contains('Remaining:') == true)
            .toList();
        expect(remainingTexts.length, greaterThan(0));
      });
    });

    group('Edge Case Widget Tests', () {
      testWidgets('handles negative remaining amounts in UI', (tester) async {
        final negativeInputs = FairSplitInputs(
          partner1Income: 800,
          partner2Income: 700,
          jointIncome: 0,
          partner1Outgoings: 400,
          partner2Outgoings: 300,
          jointOutgoings: 1200,
        );

        final results = FairSplitCalculator.calculate(negativeInputs);

        await tester.pumpWidget(
          MaterialApp(
            home: FairSplitResultsScreen(
              results: results,
              inputs: negativeInputs,
            ),
          ),
        );

        // Should render without errors even with negative values
        expect(find.byType(FairSplitResultsScreen), findsOneWidget);

        // Check that negative values are displayed
        final negativeTexts = tester
            .widgetList(find.byType(Text))
            .map((widget) => (widget as Text).data)
            .where((text) => text?.contains('£-') == true)
            .toList();
        expect(negativeTexts.isNotEmpty, true);
      });

      testWidgets('free income percentages handle zero total correctly', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResultBox(
                title: 'Test',
                jointBillsScenarioName: 'Test Joint',
                jointPartner1Spend: '£100.00',
                jointPartner1Remaining: '£0.00',
                jointPartner2Spend: '£100.00',
                jointPartner2Remaining: '£0.00',
                separateBillsScenarioName: 'Test Separate',
                separatePartner1Spend: '£100.00',
                separatePartner1Remaining: '£0.00',
                separatePartner2Spend: '£100.00',
                separatePartner2Remaining: '£0.00',
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Should handle zero remaining amounts without crashing
        expect(find.text('0.0%'), findsWidgets);
      });
    });
  });
}
