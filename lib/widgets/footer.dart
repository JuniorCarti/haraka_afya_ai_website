import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/widgets/contact_info.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
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
                  '${AppConstants.appTitle} ${AppConstants.appSubtitle}',
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
              AppConstants.appDescription,
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
                  onPressed: () {},
                  child: Text(
                    'Home',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Stories',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Programs',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Team',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Contact',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              '© ${DateTime.now().year} ${AppConstants.appTitle}. All rights reserved.',
              style: TextStyle(
                color: colorScheme.onPrimary.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}