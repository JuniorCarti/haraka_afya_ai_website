import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/utils/responsive.dart';

class HarakaAppBar extends StatelessWidget {
  final VoidCallback scrollToHero;
  final VoidCallback scrollToStories;
  final VoidCallback scrollToPrograms;
  final VoidCallback scrollToTeam;
  final VoidCallback scrollToContact;

  const HarakaAppBar({
    super.key,
    required this.scrollToHero,
    required this.scrollToStories,
    required this.scrollToPrograms,
    required this.scrollToTeam,
    required this.scrollToContact,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: isDesktop ? 120 : 100,
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
                AppConstants.appTitle,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (isDesktop) ...[
                _buildNavButton('Home', scrollToHero, context),
                _buildNavButton('Stories', scrollToStories, context),
                _buildNavButton('Programs', scrollToPrograms, context),
                _buildNavButton('Team', scrollToTeam, context),
                _buildNavButton('Contact', scrollToContact, context),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => scrollToContact(),
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
    );
  }

  Widget _buildNavButton(String label, VoidCallback onTap, BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}