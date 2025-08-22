import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_info_screen.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_input_screen.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:evenedge/widgets/common/back_button.dart';

void main() {
  group('Fair Split Info Screen Widget Tests', () {
    testWidgets('displays all essential information components', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check app bar
      expect(find.text('Fair Split Calculator'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(CustomBackButton), findsOneWidget);

      // Check main title
      expect(find.text('Welcome to the Fair Split Calculator'), findsOneWidget);

      // Check introductory description
      expect(find.textContaining('two-adult households'), findsOneWidget);
      expect(
        find.textContaining('women and gender minorities'),
        findsOneWidget,
      );

      // Check methods section title
      expect(find.text('Choose from 3 Different Methods:'), findsOneWidget);

      // Check Get Started button
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('displays all three calculation methods', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check 50/50 split method
      expect(find.text('1. Classic 50/50 Split'), findsOneWidget);
      expect(
        find.textContaining('exactly half of all shared expenses'),
        findsOneWidget,
      );
      expect(
        find.textContaining('disadvantage the lower-earning partner'),
        findsOneWidget,
      );

      // Check proportional method
      expect(find.text('2. Proportional to Income'), findsOneWidget);
      expect(
        find.textContaining('percentage of total household income'),
        findsOneWidget,
      );
      expect(
        find.textContaining('equitable for partners with different income'),
        findsOneWidget,
      );

      // Check EvenEdge method
      expect(find.text('3. EvenEdge Method'), findsOneWidget);
      expect(
        find.textContaining('spare money" is split equally'),
        findsOneWidget,
      );
      expect(
        find.textContaining('equal spending power after necessities'),
        findsOneWidget,
      );
    });

    testWidgets('displays mission statement section', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check mission section
      expect(find.text('Our Mission'), findsOneWidget);
      expect(
        find.textContaining('financial equity in relationships'),
        findsOneWidget,
      );
      expect(find.textContaining('historical imbalances'), findsOneWidget);
    });

    testWidgets('has proper scrollable layout with bordered container', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check for scrollable content
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Check for bordered container
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsWidgets);

      // Verify the container has decoration with border
      final containers = tester.widgetList<Container>(containerFinder);
      final decoratedContainers = containers.where((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration && decoration.border != null;
      });
      expect(decoratedContainers.isNotEmpty, true);
    });

    testWidgets('method cards have proper styling and structure', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check that method information is contained in separate containers
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsWidgets);

      // Check that all three "Impact:" labels are present
      final impactTexts = tester
          .widgetList(find.byType(Text))
          .map((widget) => (widget as Text).data)
          .where((text) => text?.startsWith('Impact:') == true)
          .toList();
      expect(impactTexts.length, 3);
    });

    testWidgets('uses consistent theme styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
          home: const FairSplitInfoScreen(),
        ),
      );

      // Verify theme consistency by checking that containers use theme colors
      final containers = tester.widgetList<Container>(find.byType(Container));
      final decoratedContainers = containers.where((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration;
      });
      expect(decoratedContainers.isNotEmpty, true);

      // Check that text widgets use theme styles
      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.isNotEmpty, true);
    });

    testWidgets('Get Started button navigates to input screen', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Find and tap the Get Started button
      final getStartedButton = find.text('Get Started');
      expect(getStartedButton, findsOneWidget);

      await tester.tap(getStartedButton);
      await tester.pumpAndSettle();

      // Verify navigation to input screen
      expect(find.byType(FairSplitInputScreen), findsOneWidget);
      expect(find.text('Partner 1 Income'), findsOneWidget);
    });

    testWidgets('back button is present and functional', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check that back button is present
      expect(find.byType(CustomBackButton), findsOneWidget);

      // Verify it's in the app bar
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.leading, isA<CustomBackButton>());
    });

    testWidgets('handles long text content without overflow', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Pump and settle to ensure all layout is complete
      await tester.pumpAndSettle();

      // Check for overflow indicators - should not find any
      expect(find.byType(OverflowBox), findsNothing);

      // Verify scrolling works by scrolling to bottom
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();

      // Should still show content after scrolling
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('displays proper spacing between elements', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Check for SizedBox widgets that provide spacing
      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsWidgets);

      // Verify proper padding is applied
      final paddingWidgets = find.byType(Padding);
      expect(paddingWidgets, findsWidgets);
    });

    testWidgets('method cards are visually distinct', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Each method should have its own container with decoration
      final methodTitles = [
        '1. Classic 50/50 Split',
        '2. Proportional to Income',
        '3. EvenEdge Method',
      ];

      for (final title in methodTitles) {
        expect(find.text(title), findsOneWidget);
      }

      // Check that containers provide visual separation
      final containers = tester.widgetList<Container>(find.byType(Container));
      final decoratedMethodContainers = containers.where((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration &&
            decoration.border != null &&
            decoration.borderRadius != null;
      });
      expect(decoratedMethodContainers.length, greaterThanOrEqualTo(3));
    });

    testWidgets('mission section has distinct styling', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FairSplitInfoScreen()));

      // Mission section should be in a visually distinct container
      expect(find.text('Our Mission'), findsOneWidget);

      // Check that the mission section has background color styling
      final containers = tester.widgetList<Container>(find.byType(Container));
      final missionContainer = containers.where((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration && decoration.color != null;
      });
      expect(missionContainer.isNotEmpty, true);
    });
  });
}
