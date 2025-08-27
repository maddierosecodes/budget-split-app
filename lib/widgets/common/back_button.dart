import 'package:evenedge/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppFlatColors.brown900),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
