import 'package:evenedge/theme/colors.dart';
import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppFlatColors.green600, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(20.0),
      child: child,
    );
  }
}
