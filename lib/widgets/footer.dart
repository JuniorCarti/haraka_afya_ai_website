import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/utils/responsive.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  double _scale = 1.0;

  void _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical) {
      double offset = notification.metrics.pixels / 200;
      double newScale = 1 - offset.clamp(0, 0.15);
      if (newScale != _scale) setState(() => _scale = newScale);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color _footerBackground = Color(0xFFB8DCC2); // Light green background
    final horizontalPadding = Responsive.isDesktop(context) ? 40.0 : 16.0;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _onScroll(notification);
        return false;
      },
      child: SliverToBoxAdapter(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: horizontalPadding),
          color: _footerBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: _scale,
                alignment: Alignment.center,
                child: LayoutBuilder(builder: (context, constraints) {
                  final isDesktop = Responsive.isDesktop(context);
                  return isDesktop
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Text(
                                  'H',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppConstants.appTitle,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Innovating community healthcare',
                                  style: TextStyle(
                                    color: Colors.black87.withOpacity(0.8),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Text(
                                  'H',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppConstants.appTitle,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Innovating community healthcare',
                              style: TextStyle(
                                color: Colors.black87.withOpacity(0.8),
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                }),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Home', style: TextStyle(color: Colors.black87)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Stories', style: TextStyle(color: Colors.black87)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Programs', style: TextStyle(color: Colors.black87)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Team', style: TextStyle(color: Colors.black87)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Contact', style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppConstants.appDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '© ${DateTime.now().year} ${AppConstants.appTitle}. All rights reserved.',
                style: TextStyle(
                  color: Colors.black87.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
