import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  // Remove this in production - just for demo animations
  timeDilation = 1.5;
  runApp(const HarakaAfyaWebsite());
}
class HarakaAfyaWebsite extends StatelessWidget {
  const HarakaAfyaWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haraka Afya Cancer Support Trust',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006D77),
          brightness: Brightness.light,
        ),
      ),
      home: const LandingPage(),
    );
  }
}
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _storiesKey = GlobalKey();
  final _programsKey = GlobalKey();
  final _teamKey = GlobalKey();
  final _contactKey = GlobalKey();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Replace these with your actual URLs
  final _playStoreUrl = Uri.parse('https://play.google.com/store/apps/details?id=com.example.haraka_afya');
  final _appStoreUrl = Uri.parse('https://apps.apple.com/app/idXXXXXXXXX');
  final _donationUrl = Uri.parse('https://example.org/donate');
  final _email = 'info@harakaafya.org';
  final _phone = '+254 745 8432 29';

    @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1, curve: Curves.easeOutBack),
      ),
    );
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
