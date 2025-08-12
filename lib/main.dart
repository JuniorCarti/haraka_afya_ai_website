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
                    if (isWide) ...[
                      const SizedBox(width: 40),
                      Expanded(
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1605001011156-cbf0b0f67a51?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzQwfHxDYW5jZXIlMjBzdXBwb3J0JTIwdHJ1c3R8ZW58MHx8MHx8fDA%3D',
                                fit: BoxFit.cover,
                                height: 500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
 // About Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withOpacity(0.9),
                  ],
                ),
              ),
                child: Column(
                children: [
                  Text(
                    'About Our Mission',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 800,
                    child: Text(
                      'Haraka Afya Cancer Support Trust is a community-first organization dedicated to reducing cancer mortality through early detection, patient support, and education. We mobilize local resources, run screening campaigns, and provide emotional and financial support to patients and families.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onSurface.withOpacity(0.8),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatCard('2,500+', 'Patients Supported'),
                      _buildStatCard('15+', 'Community Programs'),
                      _buildStatCard('98%', 'Satisfaction Rate'),
                      _buildStatCard('50+', 'Trained Volunteers'),
                    ],
                  ),
                ],
              ),
            ),
          ),
 // Stories Section
          SliverToBoxAdapter(
            key: _storiesKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.primaryContainer.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Patient Stories',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Real journeys — resilience, support, and hope.',
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: isWide ? 1200 : 600,
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildStoryCard(
                          'Grace\'s Journey',
                          'After early screening Grace received timely treatment and is now mentoring others.',
                          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                        _buildStoryCard(
                          'John\'s Story',
                          'John found community support and financial help that kept his treatment going.',
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                        _buildStoryCard(
                          'Aisha\'s Recovery',
                          'Aisha\'s early diagnosis saved her life — now she volunteers with Haraka Afya.',
                          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=1588&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
                // Programs Section
          SliverToBoxAdapter(
            key: _programsKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Our Programs & Services',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: isWide ? 1200 : 600,
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildProgramCard(
                          Icons.health_and_safety,
                          'Screening & Education',
                          'Community screening events & health education',
                          colorScheme.primary,
                        ),
                        _buildProgramCard(
                          Icons.psychology,
                          'Counselling',
                          'One-on-one emotional & psychological support',
                          colorScheme.secondary,
                        ),
                        _buildProgramCard(
                          Icons.group,
                          'Support Groups',
                          'Peer support & survivor networks',
                          colorScheme.tertiary,
                        ),
                        _buildProgramCard(
                          Icons.favorite,
                          'Financial Assistance',
                          'Support for treatment costs & transport',
                          colorScheme.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
  // Team Section
          SliverToBoxAdapter(
            key: _teamKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.primaryContainer.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Meet Our Team',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Passionate professionals dedicated to making a difference',
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: isWide ? 1200 : 600,
                    child: Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildTeamMember(
                          'Ridge Junior Abuto',
                          'Founder & CEO',
                          'https://images.unsplash.com/photo-1745163190343-fe6f1a3aaa1c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTZ8fG1lbiUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D',
                        ),
                        _buildTeamMember(
                          'Samuel Otieno',
                          'Community Lead',
                          'https://images.unsplash.com/photo-1662638035662-455f32fd02ad?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzJ8fG1lbiUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D',
                        ),
                        _buildTeamMember(
                          'Martha Kimani',
                          'Volunteer Coordinator',
                          'https://images.unsplash.com/photo-1611417361507-7d77bbc20a73?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjR8fHdvbWVuJTIwaW1hZ2VzfGVufDB8fDB8fHww',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
           // Contact Section
          SliverToBoxAdapter(
            key: _contactKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Get In Touch',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We\'d love to hear from you',
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: isWide ? 1000 : 600,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isWide) ...[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact Information',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    _buildContactInfo(
                                      Icons.email,
                                      'Email Us',
                                      _email,
                                      colorScheme.primary,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildContactInfo(
                                      Icons.phone,
                                      'Call Us',
                                      _phone,
                                      colorScheme.secondary,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildContactInfo(
                                      Icons.location_on,
                                      'Visit Us',
                                      'Nairobi, Kenya',
                                      colorScheme.tertiary,
                                    ),
                                    const SizedBox(height: 40),
                                    Text(
                                      'Follow Us',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const FaIcon(FontAwesomeIcons.facebook),
                                          color: colorScheme.primary,
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const FaIcon(FontAwesomeIcons.twitter),
                                          color: colorScheme.primary,
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const FaIcon(FontAwesomeIcons.instagram),
                                          color: colorScheme.primary,
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const FaIcon(FontAwesomeIcons.linkedin),
                                          color: colorScheme.primary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Send Us a Message',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Your Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'Your Message',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  FilledButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Message sent!'),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Send Message'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
           // Footer
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        'Haraka Afya Cancer Support Trust',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Compassionate care for cancer patients and families',
                    style: TextStyle(
                      color: colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => _scrollTo(_heroKey),
                        child: Text(
                          'Home',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _scrollTo(_storiesKey),
                        child: Text(
                          'Stories',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _scrollTo(_programsKey),
                        child: Text(
                          'Programs',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _scrollTo(_teamKey),
                        child: Text(
                          'Team',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _scrollTo(_contactKey),
                        child: Text(
                          'Contact',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '© ${DateTime.now().year} Haraka Afya Cancer Support Trust. All rights reserved.',
                    style: TextStyle(
                      color: colorScheme.onPrimary.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStatCard(String value, String label) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }