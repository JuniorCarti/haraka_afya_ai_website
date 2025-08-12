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
Future<void> _openUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  Widget _buildNavButton(String label, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
 @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMedium = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: isWide ? 120 : 100,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withOpacity(0.9),
                      colorScheme.primary.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Logo
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'HA',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Haraka Afya',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (isWide) ...[
                      _buildNavButton('Home', _heroKey),
                      _buildNavButton('Stories', _storiesKey),
                      _buildNavButton('Programs', _programsKey),
                      _buildNavButton('Team', _teamKey),
                      _buildNavButton('Contact', _contactKey),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () => _openUrl(_donationUrl),
                        icon: const Icon(Icons.favorite, size: 18),
                        label: const Text('Donate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.onPrimary,
                          foregroundColor: colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
                    // Hero Section
          SliverToBoxAdapter(
            key: _heroKey,
            child: Container(
              height: isWide ? 700 : 600,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withOpacity(0.9),
                    colorScheme.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 80 : 24,
                  vertical: 40,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Haraka Afya Cancer Support Trust',
                                style: TextStyle(
                                  fontSize: isWide ? 48 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onPrimary,
                                  height: 1.2,
                                ),
                                textAlign: isWide ? TextAlign.left : TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Supporting patients and families through cancer care, awareness & early detection.',
                                style: TextStyle(
                                  fontSize: isWide ? 20 : 16,
                                  color: colorScheme.onPrimary.withOpacity(0.9),
                                  height: 1.5,
                                ),
                                textAlign: isWide ? TextAlign.left : TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
                                children: [
                                  FilledButton.icon(
                                    onPressed: () => _openUrl(_playStoreUrl),
                                    icon: const Icon(Icons.android),
                                    label: const Text('Android App'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: colorScheme.onPrimary,
                                      foregroundColor: colorScheme.primary,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                  ),
                                  FilledButton.icon(
                                    onPressed: () => _openUrl(_appStoreUrl),
                                    icon: const Icon(Icons.apple),
                                    label: const Text('iOS App'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: colorScheme.onPrimary,
                                      foregroundColor: colorScheme.primary,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () => _openUrl(_donationUrl),
                                    icon: const Icon(Icons.favorite_border),
                                    label: const Text('Donate Now'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: colorScheme.onPrimary,
                                      side: BorderSide(color: colorScheme.onPrimary),
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),