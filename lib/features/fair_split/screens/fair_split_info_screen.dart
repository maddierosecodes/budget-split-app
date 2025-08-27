import 'package:evenedge/features/fair_split/screens/fair_split_input_screen.dart';
import 'package:evenedge/theme/colors.dart';
import 'package:evenedge/theme/typography.dart';
import 'package:evenedge/widgets/common/app_bar_title.dart';
import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/info_container.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class FairSplitInfoScreen extends StatelessWidget {
  const FairSplitInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const AppBarTitle(title: 'Fair Split Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: InfoContainer(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Fair Split Calculator',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This calculator is designed for two-adult households to help create a fairer financial split that tackles inequalities typically faced by women and gender minorities in household financial management.',
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Choose from 3 Different Methods:',
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildMethodCard(
                        context,
                        title: '1. Classic 50/50 Split',
                        description:
                            'Each partner contributes exactly half of all shared expenses, regardless of income differences.',
                        impact:
                            'Impact: Simple but may disadvantage the lower-earning partner.',
                      ),
                      const SizedBox(height: 16),
                      _buildMethodCard(
                        context,
                        title: '2. Proportional to Income',
                        description:
                            'Each partner contributes based on their percentage of total household income.',
                        impact:
                            'Impact: More equitable for partners with different income levels.',
                      ),
                      const SizedBox(height: 16),
                      _buildMethodCard(
                        context,
                        title: '3. EvenEdge Method',
                        description:
                            'After covering individual expenses, any remaining "spare money" is split equally between partners.',
                        impact:
                            'Impact: Ensures both partners have equal spending power after necessities.',
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppFlatColors.green100.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: AppFlatColors.green600.withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Our Mission',
                              style: AppTextStyles.titleSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'EvenEdge aims to promote financial equity in relationships by providing tools that help partners make informed decisions about money management, addressing historical imbalances in household financial responsibilities.',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FairSplitInputScreen(),
                  ),
                );
              },
              text: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodCard(
    BuildContext context, {
    required String title,
    required String description,
    required String impact,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppFlatColors.green50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppFlatColors.brown100, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(description, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 6),
          Text(
            impact,
            style: AppTextStyles.bodySmall.copyWith(
              fontStyle: FontStyle.italic,
              color: AppTextStyles.bodySmall.color?.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
