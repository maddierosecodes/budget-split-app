import 'package:evenedge/theme/colors.dart';
import 'package:evenedge/theme/typography.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppFlatColors.green600,
        primary: AppFlatColors.green600,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppFlatColors.green50,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppFlatColors.green800,
        primary: AppFlatColors.green800,
        brightness: Brightness.dark,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppFlatColors.deepPurple900,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppFlatColors.green50,
        ),
        displayMedium: AppTextStyles.displayMedium.copyWith(
          color: AppFlatColors.green50,
        ),
        displaySmall: AppTextStyles.displaySmall.copyWith(
          color: AppFlatColors.green50,
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: AppFlatColors.green50,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: AppFlatColors.green50,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: AppFlatColors.green50,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(
          color: AppFlatColors.green50,
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          color: AppFlatColors.green50,
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(
          color: AppFlatColors.green50,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.white),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: AppFlatColors.green50,
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: AppFlatColors.green50,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          color: AppFlatColors.green50,
        ),
      ),
    );
  }
}
