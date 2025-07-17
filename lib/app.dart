import 'package:evenedge/features/loading/screens/loading_screen.dart';
import 'package:evenedge/features/main_menu/screens/main_menu_screen.dart';
import 'package:evenedge/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.green,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSerifDisplay(),
          displayMedium: GoogleFonts.dmSerifDisplay(),
          displaySmall: GoogleFonts.dmSerifDisplay(),
          headlineLarge: GoogleFonts.dmSerifDisplay(),
          headlineMedium: GoogleFonts.dmSerifDisplay(),
          headlineSmall: GoogleFonts.dmSerifDisplay(),
          titleLarge: GoogleFonts.dmSerifDisplay(),
          titleMedium: GoogleFonts.workSans(fontWeight: FontWeight.w500),
          titleSmall: GoogleFonts.workSans(fontWeight: FontWeight.w500),
          bodyLarge: GoogleFonts.inter(),
          bodyMedium: GoogleFonts.inter(),
          bodySmall: GoogleFonts.inter(),
          labelLarge: GoogleFonts.workSans(fontWeight: FontWeight.w500),
          labelMedium: GoogleFonts.workSans(fontWeight: FontWeight.w500),
          labelSmall: GoogleFonts.workSans(fontWeight: FontWeight.w500),
        ),
      ),
      home: const InitialLoadingScreen(),
    );
  }
}

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({super.key});

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
