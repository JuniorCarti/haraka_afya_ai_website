import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  const HeroSection({
    required this.sectionKey,
    required this.fadeAnimation,
    required this.scaleAnimation,
    super.key,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Timer? _timer;
  int _currentPage = 0;
  bool _isDownloading = false;

  final List<String> _imageUrls = [
    "https://plus.unsplash.com/premium_photo-1667762241847-37471e8c8bc0?w=1500&auto=format&fit=crop&q=60",
    "https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=1500&auto=format&fit=crop&q=60",
    "https://images.unsplash.com/photo-1487956382158-bb926046304a?w=1500&auto=format&fit=crop&q=60",
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  void _precacheImages() {
    for (final url in _imageUrls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % _imageUrls.length;
      });
    });
  }

  Future<void> _downloadAndroidApp() async {
    const apkUrl =
        'https://github.com/JuniorCarti/Haraka-Afya_AI/releases/download/v3.0.0/app-debug.apk';

    setState(() => _isDownloading = true);

    try {
      if (await canLaunchUrl(Uri.parse(apkUrl))) {
        await launchUrl(Uri.parse(apkUrl), mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Could not launch download link');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      key: widget.sectionKey,
      child: Stack(
        children: [
          // Background slideshow
          SizedBox(
            height: screenHeight,
            width: double.infinity,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: Image.network(
                _imageUrls[_currentPage],
                key: ValueKey<String>(_imageUrls[_currentPage]),
                fit: BoxFit.cover,
                width: double.infinity,
                height: screenHeight,
              ),
            ),
          ),

          // Teal gradient overlay
          Container(
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.teal.shade800.withOpacity(0.85),
                  Colors.teal.shade400.withOpacity(0.55),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 100 : 24,
              vertical: 60,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (isDesktop) {
                  // Desktop layout
                  return Row(
                    children: [
                      Expanded(child: _buildTextContent(isDesktop, textTheme)),
                      const SizedBox(width: 60),
                      Expanded(child: _buildImagePreview(screenHeight)),
                    ],
                  );
                } else {
                  // Mobile/tablet layout
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextContent(isDesktop, textTheme),
                      const SizedBox(height: 30),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(bool isDesktop, TextTheme textTheme) {
    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: ScaleTransition(
        scale: widget.scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Text(
              '${AppConstants.appTitle}\n${AppConstants.appSubtitle}',
              style: textTheme.displayLarge?.copyWith(
                fontSize: isDesktop ? 56 : 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.1,
              ),
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              AppConstants.appDescription,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: isDesktop ? 20 : 14,
                color: Colors.white70,
                height: 1.6,
              ),
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            ),
            const SizedBox(height: 36),
            _buildActionButtons(isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(double screenHeight) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: ClipRRect(
        key: ValueKey<String>(_imageUrls[_currentPage]),
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          _imageUrls[_currentPage],
          fit: BoxFit.cover,
          width: double.infinity,
          height: screenHeight * 0.7,
        ),
      ),
    );
  }

  Widget _buildActionButtons(bool isDesktop) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: _isDownloading ? null : _downloadAndroidApp,
          icon: _isDownloading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.android, size: 24),
          label: Text(
            _isDownloading ? 'Downloading...' : 'Android App',
            style: const TextStyle(fontSize: 16),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.teal.shade900,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
        FilledButton.icon(
          onPressed: () => _launchUrl(AppConstants.appStoreUrl),
          icon: const Icon(Icons.apple, size: 24),
          label: const Text('iOS App', style: TextStyle(fontSize: 16)),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.teal.shade900,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _launchUrl(AppConstants.donationUrl),
          icon: const Icon(Icons.favorite_border,
              size: 24, color: Colors.white),
          label: const Text(
            'Donate Now',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2),
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
