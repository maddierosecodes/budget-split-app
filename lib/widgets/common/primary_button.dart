import 'package:flutter/material.dart';
import 'package:evenedge/theme/colors.dart';
import 'package:evenedge/theme/typography.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppFlatColors.purple800,
          foregroundColor: AppFlatColors.green900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ), // Pill shape like your screenshot
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: Text(
          text,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppFlatColors.green300,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
