import 'package:evenedge/theme/colors.dart';
import 'package:evenedge/theme/typography.dart';
import 'package:flutter/material.dart';

class HouseholdInfoBox extends StatelessWidget {
  const HouseholdInfoBox({
    required this.partner1Income,
    required this.partner2Income,
    required this.jointIncome,
    required this.partner1Outgoings,
    required this.partner2Outgoings,
    required this.jointOutgoings,
    super.key,
  });

  final double partner1Income;
  final double partner2Income;
  final double jointIncome;
  final double partner1Outgoings;
  final double partner2Outgoings;
  final double jointOutgoings;

  @override
  Widget build(BuildContext context) {
    // Calculate totals
    final totalHouseholdIncome = partner1Income + partner2Income + jointIncome;
    final totalHouseholdBills =
        partner1Outgoings + partner2Outgoings + jointOutgoings;

    // Calculate each partner's total income (including their share of joint)
    final partner1TotalIncome = partner1Income + (jointIncome / 2);
    final partner2TotalIncome = partner2Income + (jointIncome / 2);
    final totalIndividualIncome = partner1TotalIncome + partner2TotalIncome;

    // Calculate percentages
    final partner1Percentage = totalIndividualIncome > 0
        ? (partner1TotalIncome / totalIndividualIncome) * 100
        : 0.0;
    final partner2Percentage = totalIndividualIncome > 0
        ? (partner2TotalIncome / totalIndividualIncome) * 100
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppFlatColors.green100.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppFlatColors.green600),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppFlatColors.green600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Household Summary',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppFlatColors.green600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Income and Bills Summary
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Household Income',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '£${totalHouseholdIncome.toStringAsFixed(2)}',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppFlatColors.green600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Household Bills',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '£${totalHouseholdBills.toStringAsFixed(2)}',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppFlatColors.purple900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Income Percentages
          Text(
            'Income Distribution',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppFlatColors.brown50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: AppFlatColors.brown100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Partner 1',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${partner1Percentage.toStringAsFixed(1)}%',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppFlatColors.brown900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '£${partner1TotalIncome.toStringAsFixed(2)}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppFlatColors.brown50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: AppFlatColors.brown100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Partner 2',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${partner2Percentage.toStringAsFixed(1)}%',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppFlatColors.brown900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '£${partner2TotalIncome.toStringAsFixed(2)}',
                        style: AppTextStyles.bodySmall,
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
}
