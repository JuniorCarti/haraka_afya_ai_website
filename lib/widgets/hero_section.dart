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
  final PageController _pageController = PageController(viewportFraction: 0.9);
  Timer? _timer;
  int _currentPage = 0;
  bool _isDownloading = false;

  final List<String> _imageUrls = [
    'https://plus.unsplash.com/premium_photo-1663047725430-f855f465b6a4?auto=format&fit=max&w=1500',
    'https://plus.unsplash.com/premium_photo-1744491220300-39cf2b24ccd1?auto=format&fit=max&w=1500',
    'https://images.unsplash.com/photo-1502139214982-d0ad755818d8?auto=format&fit=max&w=1500',
    'https://images.unsplash.com/photo-1508175749578-259ded3db070?auto=format&fit=max&w=1500'
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
      if (_currentPage < _imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  Future<void> _downloadAndroidApp() async {
    const apkUrl = 'https://github.com/JuniorCarti/Haraka-Afya_AI/releases/download/v3.0.0/app-debug.apk';
    
    setState(() {
      _isDownloading = true;
    });

    try {
      if (await canLaunchUrl(Uri.parse(apkUrl))) {
        await launchUrl(
          Uri.parse(apkUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch download link')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      key: widget.sectionKey,
      child: Container(
        height: isDesktop ? 750 : 650,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withOpacity(0.95),
              colorScheme.primary.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100 : 24,
            vertical: 60,
          ),
          child: Row(
            children: [
              Expanded(
                child: FadeTransition(
                  opacity: widget.fadeAnimation,
                  child: ScaleTransition(
                    scale: widget.scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: isDesktop 
                          ? CrossAxisAlignment.start 
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${AppConstants.appTitle}\n${AppConstants.appSubtitle}',
                          style: textTheme.displayLarge?.copyWith(
                            fontSize: isDesktop ? 56 : 36,
                            fontWeight: FontWeight.w900,
                            color: colorScheme.onPrimary,
                            height: 1.1,
                          ),
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppConstants.appDescription,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: isDesktop ? 20 : 16,
                            color: colorScheme.onPrimary.withOpacity(0.85),
                            height: 1.6,
                          ),
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: 36),
                        _buildActionButtons(context, isDesktop),
                      ],
                    ),
                  ),
                ),
              ),
              if (isDesktop) ...[
                const SizedBox(width: 60),
                Expanded(
                  child: FadeTransition(
                    opacity: widget.fadeAnimation,
                    child: ScaleTransition(
                      scale: widget.scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 520,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                PageView.builder(
                                  controller: _pageController,
                                  itemCount: _imageUrls.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          _imageUrls[index],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: Colors.black12,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      _imageUrls.length,
                                      (index) => AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: _currentPage == index ? 24 : 10,
                                        height: 10,
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: _currentPage == index
                                              ? colorScheme.onPrimary
                                              : colorScheme.onPrimary.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDesktop) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Wrap(
      spacing: 20,
      runSpacing: 16,
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
            backgroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
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
            backgroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _launchUrl(AppConstants.donationUrl),
          icon: const Icon(Icons.favorite_border, size: 24),
          label: const Text('Donate Now', style: TextStyle(fontSize: 16)),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            side: BorderSide(color: colorScheme.onPrimary, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}