import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Preload fonts to prevent UI blocking
  static Future<void> preloadFonts() async {
    await GoogleFonts.pendingFonts([
      GoogleFonts.dmSerifDisplay(),
      GoogleFonts.workSans(),
      GoogleFonts.inter(),
    ]);
  }

  static final displayLarge = GoogleFonts.dmSerifDisplay(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final displayMedium = GoogleFonts.dmSerifDisplay(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final displaySmall = GoogleFonts.dmSerifDisplay(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final headlineLarge = GoogleFonts.dmSerifDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final headlineMedium = GoogleFonts.dmSerifDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final headlineSmall = GoogleFonts.dmSerifDisplay(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final titleLarge = GoogleFonts.dmSerifDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final titleMedium = GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppFlatColors.deepPurple900,
  );

  static final titleSmall = GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppFlatColors.deepPurple900,
  );

  static final bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppFlatColors.deepPurple900,
  );

  static final labelLarge = GoogleFonts.workSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppFlatColors.deepPurple900,
  );

  static final labelMedium = GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppFlatColors.deepPurple900,
  );

  static final labelSmall = GoogleFonts.workSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppFlatColors.deepPurple900,
  );
}
