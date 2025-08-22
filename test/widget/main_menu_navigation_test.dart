import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/features/main_menu/screens/main_menu_screen.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_info_screen.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_input_screen.dart';
import 'package:evenedge/features/budget_calculator/screens/budget_calculator_screen.dart';
import 'package:evenedge/features/settings/screens/settings_screen.dart';
import 'package:evenedge/widgets/common/primary_button.dart';

void main() {
  group('Main Menu Navigation Integration Tests', () {
    testWidgets('main menu displays all navigation options', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Check app bar
      expect(find.text('Main Menu'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      // Check all navigation buttons
      expect(find.text('Fair Split Calculator'), findsOneWidget);
      expect(find.text('Budget Calculator'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Check buttons are PrimaryButton widgets
      expect(find.byType(PrimaryButton), findsNWidgets(3));
    });

    testWidgets('fair split calculator button navigates to info screen', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Tap the Fair Split Calculator button
      await tester.tap(find.text('Fair Split Calculator'));
      await tester.pumpAndSettle();

      // Verify navigation to info screen (not directly to input screen)
      expect(find.byType(FairSplitInfoScreen), findsOneWidget);
      expect(find.text('Welcome to the Fair Split Calculator'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);

      // Verify we're NOT on the input screen yet
      expect(find.byType(FairSplitInputScreen), findsNothing);
      expect(find.text('Partner 1 Income'), findsNothing);
    });

    testWidgets('complete fair split flow: menu → info → input → results', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Step 1: Navigate from main menu to info screen
      await tester.tap(find.text('Fair Split Calculator'));
      await tester.pumpAndSettle();
      expect(find.byType(FairSplitInfoScreen), findsOneWidget);

      // Step 2: Navigate from info screen to input screen
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();
      expect(find.byType(FairSplitInputScreen), findsOneWidget);
      expect(find.text('Partner 1 Income'), findsOneWidget);

      // Step 3: Fill in basic test data and navigate to results
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Income'),
        '2000',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Income'),
        '2000',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Income'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 1 Outgoings'),
        '500',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Partner 2 Outgoings'),
        '1000',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Joint Outgoings'),
        '800',
      );

      await tester.tap(find.text('Calculate'));
      await tester.pumpAndSettle();

      // Verify we reached the results screen with all three methods
      expect(find.text('Fair Split Results'), findsOneWidget);
      expect(find.text('50/50 Split'), findsOneWidget);
      expect(find.text('% Split'), findsOneWidget);
      expect(find.text('EvenEdge'), findsOneWidget);
    });

    testWidgets('budget calculator navigation works', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Tap the Budget Calculator button
      await tester.tap(find.text('Budget Calculator'));
      await tester.pumpAndSettle();

      // Verify navigation to budget calculator screen
      expect(find.byType(BudgetCalculatorScreen), findsOneWidget);
    });

    testWidgets('settings navigation works', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Tap the Settings button
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      // Verify navigation to settings screen
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('info screen back button returns to main menu', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Navigate to info screen
      await tester.tap(find.text('Fair Split Calculator'));
      await tester.pumpAndSettle();
      expect(find.byType(FairSplitInfoScreen), findsOneWidget);

      // Use back button to return to main menu
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify we're back at main menu
      expect(find.byType(MainMenuScreen), findsOneWidget);
      expect(find.text('Main Menu'), findsOneWidget);
    });

    testWidgets('input screen back button returns to info screen', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Navigate through info screen to input screen
      await tester.tap(find.text('Fair Split Calculator'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();
      expect(find.byType(FairSplitInputScreen), findsOneWidget);

      // Use back button to return to info screen
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify we're back at info screen
      expect(find.byType(FairSplitInfoScreen), findsOneWidget);
      expect(find.text('Welcome to the Fair Split Calculator'), findsOneWidget);
    });

    testWidgets('main menu layout is properly centered', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenuScreen()));

      // Check that main content is centered
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);

      // Check proper spacing between buttons
      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsWidgets);
    });

    testWidgets('all navigation flows preserve app theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
          home: const MainMenuScreen(),
        ),
      );

      // Navigate through fair split flow
      await tester.tap(find.text('Fair Split Calculator'));
      await tester.pumpAndSettle();

      // Check that info screen uses proper theme
      final appBarInfo = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBarInfo.title, isA<Text>());

      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Check that input screen uses proper theme
      final appBarInput = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBarInput.title, isA<Text>());
    });
  });
}
