import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/utils/responsive.dart';

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
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<String> _imageUrls = [
    'https://plus.unsplash.com/premium_photo-1663047725430-f855f465b6a4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aGVhbGluZ3xlbnwwfDB8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1744491220300-39cf2b24ccd1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDl8fGhlYWxpbmd8ZW58MHwwfDB8fHww',
    'https://images.unsplash.com/photo-1502139214982-d0ad755818d8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjB8fGhlYWxpbmd8ZW58MHwwfDB8fHww',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
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
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      key: widget.sectionKey,
      child: Container(
        height: isDesktop ? 700 : 600,
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
            horizontal: isDesktop ? 80 : 24,
            vertical: 40,
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
                      crossAxisAlignment:
                          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${AppConstants.appTitle}\n${AppConstants.appSubtitle}',
                          style: TextStyle(
                            fontSize: isDesktop ? 48 : 32,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimary,
                            height: 1.2,
                          ),
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppConstants.appDescription,
                          style: TextStyle(
                            fontSize: isDesktop ? 20 : 16,
                            color: colorScheme.onPrimary.withOpacity(0.9),
                            height: 1.5,
                          ),
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        _buildActionButtons(context, isDesktop),
                      ],
                    ),
                  ),
                ),
              ),
              if (isDesktop) ...[
                const SizedBox(width: 40),
                Expanded(
                  child: FadeTransition(
                    opacity: widget.fadeAnimation,
                    child: ScaleTransition(
                      scale: widget.scaleAnimation,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 500,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: _imageUrls.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    _imageUrls[index],
                                    fit: BoxFit.cover,
                                    height: 500,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _imageUrls.length,
                                  (index) => Container(
                                    width: 10,
                                    height: 10,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
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
      spacing: 16,
      runSpacing: 16,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: () => _launchUrl(AppConstants.playStoreUrl),
          icon: const Icon(Icons.android),
          label: const Text('Android App'),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        FilledButton.icon(
          onPressed: () => _launchUrl(AppConstants.appStoreUrl),
          icon: const Icon(Icons.apple),
          label: const Text('iOS App'),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _launchUrl(AppConstants.donationUrl),
          icon: const Icon(Icons.favorite_border),
          label: const Text('Donate Now'),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            side: BorderSide(color: colorScheme.onPrimary),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ],
    );
  }

  void _launchUrl(String url) {
    // Implement URL launching
  }
}