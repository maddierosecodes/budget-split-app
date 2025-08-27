import 'package:evenedge/theme/colors.dart';
import 'package:evenedge/theme/typography.dart';
import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    required this.title,
    required this.jointBillsScenarioName,
    required this.jointPartner1Spend,
    required this.jointPartner1Remaining,
    required this.jointPartner2Spend,
    required this.jointPartner2Remaining,
    required this.separateBillsScenarioName,
    required this.separatePartner1Spend,
    required this.separatePartner1Remaining,
    required this.separatePartner2Spend,
    required this.separatePartner2Remaining,
    super.key,
  });

  final String title;

  // Joint Bills Scenario
  final String jointBillsScenarioName;
  final String jointPartner1Spend;
  final String jointPartner1Remaining;
  final String jointPartner2Spend;
  final String jointPartner2Remaining;

  // Separate Bills Scenario
  final String separateBillsScenarioName;
  final String separatePartner1Spend;
  final String separatePartner1Remaining;
  final String separatePartner2Spend;
  final String separatePartner2Remaining;

  // Helper method to extract numeric value from currency string
  double _parseAmount(String amount) {
    return double.tryParse(amount.replaceAll('£', '').replaceAll(',', '')) ??
        0.0;
  }

  // Helper method to calculate free income percentages
  Map<String, double> _calculateFreeIncomePercentages(
    String partner1Remaining,
    String partner2Remaining,
  ) {
    final partner1Amount = _parseAmount(partner1Remaining);
    final partner2Amount = _parseAmount(partner2Remaining);
    final totalFreeIncome = partner1Amount + partner2Amount;

    if (totalFreeIncome == 0) {
      return {'partner1': 0.0, 'partner2': 0.0};
    }

    return {
      'partner1': (partner1Amount / totalFreeIncome) * 100,
      'partner2': (partner2Amount / totalFreeIncome) * 100,
    };
  }

  // Helper method to build scenario container
  Widget _buildScenarioContainer(
    BuildContext context,
    String scenarioName,
    String partner1Spend,
    String partner1Remaining,
    String partner2Spend,
    String partner2Remaining,
    Color backgroundColor,
    Color? borderColor,
  ) {
    final percentages = _calculateFreeIncomePercentages(
      partner1Remaining,
      partner2Remaining,
    );

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.0),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            scenarioName,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Partner 1 Spend: $partner1Spend'),
                    Text('Partner 1 Remaining: $partner1Remaining'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Partner 2 Spend: $partner2Spend'),
                    Text('Partner 2 Remaining: $partner2Remaining'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Free Income Distribution
          Text(
            'Free Income Distribution',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppFlatColors.green600,
            ),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: AppFlatColors.brown50,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: AppFlatColors.brown100),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Partner 1',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${percentages['partner1']!.toStringAsFixed(1)}%',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppFlatColors.brown900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: AppFlatColors.brown50,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: AppFlatColors.brown100),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Partner 2',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${percentages['partner2']!.toStringAsFixed(1)}%',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppFlatColors.brown900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppFlatColors.green600),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.titleLarge),
          const SizedBox(height: 16),

          // Joint Bills Scenario
          _buildScenarioContainer(
            context,
            jointBillsScenarioName,
            jointPartner1Spend,
            jointPartner1Remaining,
            jointPartner2Spend,
            jointPartner2Remaining,
            AppFlatColors.green100.withOpacity(0.5),
            null,
          ),

          const SizedBox(height: 12),

          // Separate Bills Scenario
          _buildScenarioContainer(
            context,
            separateBillsScenarioName,
            separatePartner1Spend,
            separatePartner1Remaining,
            separatePartner2Spend,
            separatePartner2Remaining,
            AppFlatColors.green100.withOpacity(0.2),
            AppFlatColors.green600.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
