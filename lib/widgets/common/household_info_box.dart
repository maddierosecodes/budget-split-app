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
    final theme = Theme.of(context);

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
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: theme.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Household Summary',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
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
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '£${totalHouseholdIncome.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.green[700],
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
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '£${totalHouseholdBills.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.red[700],
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
            style: theme.textTheme.bodyMedium?.copyWith(
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
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Partner 1',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${partner1Percentage.toStringAsFixed(1)}%',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '£${partner1TotalIncome.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall,
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
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Partner 2',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${partner2Percentage.toStringAsFixed(1)}%',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '£${partner2TotalIncome.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall,
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
