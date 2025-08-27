import 'package:evenedge/features/budget_calculator/screens/budget_calculator_screen.dart';
import 'package:evenedge/features/fair_split/screens/fair_split_info_screen.dart';
import 'package:evenedge/features/settings/screens/settings_screen.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:evenedge/theme/assets.dart';
import 'package:evenedge/theme/typography.dart';
import 'package:evenedge/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  Future<void> _launchSupportUrl() async {
    final Uri url = Uri.parse('https://maddierosecodes.com');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width:
                      MediaQuery.of(context).size.width *
                      0.7, // Constrain to 70% of screen width
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      SvgPicture.asset(AppAssets.logo, width: 150, height: 150),
                      const SizedBox(height: 10),

                      // Title
                      Text(
                        'EvenEdge',
                        style: AppTextStyles.displayMedium.copyWith(
                          color: AppFlatColors.purple800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sub-Title
                      Text(
                        'Promoting Financial Equity',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppFlatColors.brown800,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Buttons
                      PrimaryButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FairSplitInfoScreen(),
                            ),
                          );
                        },
                        text: 'Fair Split Calculator',
                        width: double
                            .infinity, // Takes full width of the constrained parent
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BudgetCalculatorScreen(),
                            ),
                          );
                        },
                        text: 'Budget Calculator',
                        width: double.infinity,
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                        text: 'Settings',
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Support link at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: GestureDetector(
                onTap: _launchSupportUrl,
                child: Text(
                  'Support the Developer',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppFlatColors.brown900,
                    decoration: TextDecoration.underline,
                    decorationColor: AppFlatColors.purple600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
