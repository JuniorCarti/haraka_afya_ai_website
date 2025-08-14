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
    final isTablet = Responsive.isTablet(context);
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
        titlePadding: const EdgeInsets.symmetric(horizontal: 16),
        title: LayoutBuilder(
          builder: (context, constraints) {
            if (isDesktop) {
              // Full navigation
              return Row(
                children: [
                  _buildLogo(colorScheme),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      AppConstants.appTitle,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  _buildNavButton('Home', scrollToHero, context),
                  _buildNavButton('Stories', scrollToStories, context),
                  _buildNavButton('Programs', scrollToPrograms, context),
                  _buildNavButton('Team', scrollToTeam, context),
                  _buildNavButton('Contact', scrollToContact, context),
                  const SizedBox(width: 12),
                  _buildDonateButton(colorScheme),
                ],
              );
            } else if (isTablet) {
              // Tablet: menu for nav, but donate button stays visible
              return Row(
                children: [
                  _buildLogo(colorScheme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppConstants.appTitle,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  _buildPopupMenu(includeDonate: false),
                  const SizedBox(width: 8),
                  _buildDonateButton(colorScheme),
                ],
              );
            } else {
              // Mobile: all in menu
              return Row(
                children: [
                  _buildLogo(colorScheme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppConstants.appTitle,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  _buildPopupMenu(includeDonate: true),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLogo(ColorScheme colorScheme) {
    return Container(
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
    );
  }

  Widget _buildNavButton(
    String label,
    VoidCallback onTap,
    BuildContext context,
  ) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildDonateButton(ColorScheme colorScheme) {
    return ElevatedButton.icon(
      onPressed: scrollToContact,
      icon: const Icon(Icons.favorite, size: 18),
      label: const Text('Donate'),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onPrimary,
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  Widget _buildPopupMenu({required bool includeDonate}) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.white),
      onSelected: (value) {
        switch (value) {
          case 'Home':
            scrollToHero();
            break;
          case 'Stories':
            scrollToStories();
            break;
          case 'Programs':
            scrollToPrograms();
            break;
          case 'Team':
            scrollToTeam();
            break;
          case 'Contact':
            scrollToContact();
            break;
          case 'Donate':
            scrollToContact();
            break;
        }
      },
      itemBuilder: (context) {
        final List<PopupMenuEntry<String>> items = [
          const PopupMenuItem(value: 'Home', child: Text('Home')),
          const PopupMenuItem(value: 'Stories', child: Text('Stories')),
          const PopupMenuItem(value: 'Programs', child: Text('Programs')),
          const PopupMenuItem(value: 'Team', child: Text('Team')),
          const PopupMenuItem(value: 'Contact', child: Text('Contact')),
        ];
        if (includeDonate) {
          items.add(const PopupMenuDivider());
          items.add(
            const PopupMenuItem(value: 'Donate', child: Text('Donate')),
          );
        }
        return items;
      },
    );
  }
}
