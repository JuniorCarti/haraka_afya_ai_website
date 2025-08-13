import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:google_fonts/google_fonts.dart';
import 'package:haraka_afya_ai_website/screens/landing_page.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';

void main() {
  // Remove timeDilation in production
  timeDilation = 1.5;
  runApp(const HarakaAfyaApp());
}

class HarakaAfyaApp extends StatelessWidget {
  const HarakaAfyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppConstants.appTitle} | ${AppConstants.appSubtitle}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: AppConstants.textColor,
          displayColor: AppConstants.textColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const LandingPage(),
    );
  }
}