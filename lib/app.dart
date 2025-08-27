import 'package:evenedge/features/loading/screens/loading_screen.dart';
import 'package:evenedge/features/main_menu/screens/main_menu_screen.dart';
import 'package:evenedge/theme/app_theme.dart';
import 'package:evenedge/theme/typography.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // or .light, .dark
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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Preload fonts to prevent UI blocking
    await AppTextStyles.preloadFonts();

    // Add a minimum loading time for better UX
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to main menu
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
