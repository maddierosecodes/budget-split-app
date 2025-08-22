import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_input_screen.dart';

void main() {
  group('Real-time Validation Tests', () {
    testWidgets(
      'error message appears when field is left empty after unfocus',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: FairSplitInputScreen()),
        );

        // Find the first text field
        final textField = find.widgetWithText(
          TextFormField,
          'Partner 1 Income',
        );

        // Focus the field - should not show error yet
        await tester.tap(textField);
        await tester.pump();

        // No error should be shown just from focusing
        expect(find.text('Partner 1 Income is required'), findsNothing);

        // Leave field empty and unfocus to trigger validation
        await tester.tap(find.byType(Scaffold));
        await tester.pump();

        // Now should show validation error after unfocusing empty field
        expect(find.text('Partner 1 Income is required'), findsOneWidget);
      },
    );

    testWidgets('error message disappears when input becomes valid', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      final textField = find.widgetWithText(TextFormField, 'Partner 1 Income');

      // First trigger an error by leaving field empty
      await tester.tap(textField);
      await tester.pump();
      await tester.enterText(textField, '');
      await tester.pump();
      await tester.tap(find.byType(Scaffold));
      await tester.pump();

      // Verify error is shown
      expect(find.text('Partner 1 Income is required'), findsOneWidget);

      // Now enter valid input
      await tester.tap(textField);
      await tester.pump();
      await tester.enterText(textField, '1000');
      await tester.pumpAndSettle();

      // Error should disappear immediately after entering valid text
      expect(find.text('Partner 1 Income is required'), findsNothing);
    });

    testWidgets('validation works for all currency requirements', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      final textField = find.widgetWithText(TextFormField, 'Partner 1 Income');

      // Test valid decimal input
      await tester.enterText(textField, '123.45');
      await tester.pump();

      // Should not show any error
      expect(find.textContaining('is required'), findsNothing);
      expect(find.textContaining('valid amount'), findsNothing);
      expect(find.textContaining('decimal places'), findsNothing);

      // Test valid whole number
      await tester.enterText(textField, '1000');
      await tester.pump();

      // Should not show any error
      expect(find.textContaining('is required'), findsNothing);
      expect(find.textContaining('valid amount'), findsNothing);
      expect(find.textContaining('decimal places'), findsNothing);

      // Test zero value
      await tester.enterText(textField, '0');
      await tester.pump();

      // Should not show any error
      expect(find.textContaining('is required'), findsNothing);
      expect(find.textContaining('valid amount'), findsNothing);
      expect(find.textContaining('decimal places'), findsNothing);
    });

    testWidgets('multiple fields validate independently in real-time', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      final partner1Field = find.widgetWithText(
        TextFormField,
        'Partner 1 Income',
      );
      final partner2Field = find.widgetWithText(
        TextFormField,
        'Partner 2 Income',
      );

      // Leave partner1 empty (should show error)
      await tester.tap(partner1Field);
      await tester.pump();
      await tester.enterText(partner1Field, '');
      await tester.tap(find.byType(Scaffold));
      await tester.pump();

      // Fill partner2 with valid value (should not show error)
      await tester.enterText(partner2Field, '2000');
      await tester.pump();

      // Check that only partner1 shows error
      expect(find.text('Partner 1 Income is required'), findsOneWidget);
      expect(find.text('Partner 2 Income is required'), findsNothing);

      // Now fix partner1
      await tester.tap(partner1Field);
      await tester.pump();
      await tester.enterText(partner1Field, '1500');
      await tester.pumpAndSettle();

      // Both fields should be error-free
      expect(find.text('Partner 1 Income is required'), findsNothing);
      expect(find.text('Partner 2 Income is required'), findsNothing);
    });

    testWidgets('validation only triggers on unfocus, not on initial focus', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Initially, no validation errors should be shown
      expect(find.textContaining('is required'), findsNothing);

      final textField = find.widgetWithText(TextFormField, 'Partner 1 Income');

      // Focusing field should not trigger validation
      await tester.tap(textField);
      await tester.pump();

      // Still no error after focusing
      expect(find.text('Partner 1 Income is required'), findsNothing);

      // Only after unfocusing empty field should validation trigger
      await tester.tap(find.byType(Scaffold)); // Unfocus
      await tester.pump();

      // Now error should appear
      expect(find.text('Partner 1 Income is required'), findsOneWidget);
    });

    testWidgets('typing valid input immediately shows no errors', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      final textField = find.widgetWithText(TextFormField, 'Partner 1 Income');

      // Focus and immediately type valid content
      await tester.tap(textField);
      await tester.pump();
      await tester.enterText(textField, '2000');
      await tester.pump();

      // Should not show any errors while typing valid input
      expect(find.textContaining('is required'), findsNothing);
      expect(find.textContaining('valid amount'), findsNothing);

      // Even after unfocusing, should remain error-free
      await tester.tap(find.byType(Scaffold));
      await tester.pump();

      expect(find.textContaining('is required'), findsNothing);
      expect(find.textContaining('valid amount'), findsNothing);
    });

    testWidgets('form submission still validates all fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInputScreen()));

      // Leave all fields empty and try to submit
      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Should show all required field errors
      expect(find.text('Partner 1 Income is required'), findsOneWidget);
      expect(find.text('Partner 2 Income is required'), findsOneWidget);
      expect(find.text('Joint Income is required'), findsOneWidget);
      expect(find.text('Partner 1 Outgoings is required'), findsOneWidget);
      expect(find.text('Partner 2 Outgoings is required'), findsOneWidget);
      expect(find.text('Joint Outgoings is required'), findsOneWidget);

      // And the snackbar
      expect(
        find.text('Please fix the errors above before continuing'),
        findsOneWidget,
      );
    });
  });
}
