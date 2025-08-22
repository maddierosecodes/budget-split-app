import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_input_screen.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_results_screen.dart';
import 'package:evenedge/widgets/common/custom_text_field.dart';

void main() {
  group('Fair Split Input Screen Validation Tests', () {
    testWidgets('displays all input fields with validation', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Check all input fields are present
      expect(find.text('Partner 1 Income'), findsOneWidget);
      expect(find.text('Partner 2 Income'), findsOneWidget);
      expect(find.text('Joint Income'), findsOneWidget);
      expect(find.text('Partner 1 Outgoings'), findsOneWidget);
      expect(find.text('Partner 2 Outgoings'), findsOneWidget);
      expect(find.text('Joint Outgoings'), findsOneWidget);

      // Check all fields have proper formatting
      expect(find.byType(CustomTextField), findsNWidgets(6));
      expect(find.text('Calculate'), findsOneWidget);
    });

    testWidgets('shows validation errors for empty required fields', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Tap calculate without entering any values
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Check validation error messages appear
      expect(find.text('Partner 1 Income is required'), findsOneWidget);
      expect(find.text('Partner 2 Income is required'), findsOneWidget);
      expect(find.text('Joint Income is required'), findsOneWidget);
      expect(find.text('Partner 1 Outgoings is required'), findsOneWidget);
      expect(find.text('Partner 2 Outgoings is required'), findsOneWidget);
      expect(find.text('Joint Outgoings is required'), findsOneWidget);

      // Check snackbar message appears
      expect(
        find.text('Please fix the errors above before continuing'),
        findsOneWidget,
      );
    });

    testWidgets('accepts valid currency input with decimals', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Enter valid currency values
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '2500.50',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Income'),
        '2000.00',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Income'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Outgoings'),
        '500.25',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Outgoings'),
        '750.75',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Outgoings'),
        '1200.00',
      );

      // Tap calculate
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Should navigate to results screen
      expect(find.byType(FairSplitResultsScreen), findsOneWidget);
    });

    testWidgets('accepts zero values in all fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Enter zero in all fields
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Income'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Income'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Outgoings'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Outgoings'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Outgoings'),
        '0',
      );

      // Tap calculate
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Should navigate to results screen
      expect(find.byType(FairSplitResultsScreen), findsOneWidget);
    });

    testWidgets('prevents negative input with formatter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Try to enter negative value - formatter should prevent it
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '-100',
      );

      // Check that the negative value was not entered (formatter blocked it)
      final textField = tester.widget<TextFormField>(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
      );
      expect(textField.controller?.text, equals(''));

      // Now enter a valid value to show formatter works both ways
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '100',
      );

      expect(textField.controller?.text, equals('100'));
    });

    testWidgets('prevents invalid text input with formatter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Try to enter text - formatter should prevent it
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        'abc',
      );

      // Check that the text was not entered (formatter blocked it)
      final textField = tester.widget<TextFormField>(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
      );
      expect(textField.controller?.text, equals(''));

      // Verify we can still enter valid numbers
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '123.45',
      );

      expect(textField.controller?.text, equals('123.45'));
    });

    testWidgets('prevents more than 2 decimal places with formatter', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // First enter a valid 2-decimal value
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '2000.12',
      );

      final textField = tester.widget<TextFormField>(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
      );
      expect(textField.controller?.text, equals('2000.12'));

      // Now try to add a third decimal place - should be prevented
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '2000.123',
      );

      // Should still only have 2 decimal places
      expect(textField.controller?.text, equals('2000.12'));
    });

    testWidgets('displays currency prefix and hint text', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Check that currency prefix and hints are displayed
      expect(find.text('£ '), findsNWidgets(6));
      expect(find.text('0.00'), findsNWidgets(6));
    });

    testWidgets('validates each field independently for empty values', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Leave some fields empty and fill others
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '2000',
      );
      // Partner 2 Income left empty
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Income'),
        '0',
      );
      // Partner 1 Outgoings left empty
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Outgoings'),
        '750',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Outgoings'),
        '1200',
      );

      // Tap calculate
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Should show validation errors for empty fields only
      expect(find.text('Partner 2 Income is required'), findsOneWidget);
      expect(find.text('Partner 1 Outgoings is required'), findsOneWidget);
      expect(
        find.text('Please fix the errors above before continuing'),
        findsOneWidget,
      );
    });

    testWidgets('form preserves entered values after validation error', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Enter some valid values and leave one empty
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '2500',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Income'),
        '2000',
      );
      // Leave Joint Income empty to trigger validation error

      // Tap calculate to trigger validation
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Check that valid values are preserved
      final partner1Field = tester.widget<TextFormField>(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
      );
      expect(partner1Field.controller?.text, equals('2500'));

      final partner2Field = tester.widget<TextFormField>(
        find.widgetWithText(TextFormField, 'Partner 2 Income'),
      );
      expect(partner2Field.controller?.text, equals('2000'));
    });

    testWidgets('successful validation navigates to results screen', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Enter all valid values
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '3000',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Income'),
        '2000',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Income'),
        '500',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Outgoings'),
        '600',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Outgoings'),
        '400',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Outgoings'),
        '1000',
      );

      // Tap calculate
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Should navigate to results screen
      expect(find.byType(FairSplitResultsScreen), findsOneWidget);
      expect(find.text('Fair Split Results'), findsOneWidget);
    });
  });
}
