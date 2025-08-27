import 'package:evenedge/theme/typography.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.titleLarge);
  }
}
