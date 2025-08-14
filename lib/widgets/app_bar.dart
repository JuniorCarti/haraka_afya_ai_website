import 'dart:ui';
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

  static const Color _lightGreen = Color(0xFFC8E6C9);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final maxHeight = isDesktop ? 110.0 : 90.0;

    return SliverAppBar(
      expandedHeight: maxHeight,
      floating: true,
      pinned: true,
      backgroundColor: _lightGreen,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final percent = ((constraints.maxHeight - kToolbarHeight) /
                  (maxHeight - kToolbarHeight))
              .clamp(0.0, 1.0);

          final slideUp = Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: const Offset(0, 0),
          ).transform(1 - percent);

          final fadeIn = 1 - percent;

          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            titlePadding:
                EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 16, vertical: 8),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: scrollToHero,
                  child: Text(
                    AppConstants.appTitle,
                    style: TextStyle(
                      fontSize: 20 - 4 * (1 - percent),
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                SizedBox(width: percent > 0.7 ? 0 : 8),
                if (percent < 1)
                  Opacity(
                    opacity: fadeIn,
                    child: Transform.translate(
                      offset: Offset(0, 12 * slideUp.dy),
                      child: Row(
                        children: [
                          Text(
                            'Innovating community healthcare',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 24,
                            height: 24,
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
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const Spacer(),
                if (isDesktop) ...[
                  _NavButton(label: 'Home', onTap: scrollToHero),
                  _NavButton(label: 'Stories', onTap: scrollToStories),
                  _NavButton(label: 'Programs', onTap: scrollToPrograms),
                  _NavButton(label: 'Team', onTap: scrollToTeam),
                  _NavButton(label: 'Contact', onTap: scrollToContact),
                  const SizedBox(width: 24),
                  OutlinedButton(
                    onPressed: scrollToContact,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Donate'),
                  ),
                ],
                if (!isDesktop)
                  _MobileMenuButton(
                    scrollToHero: scrollToHero,
                    scrollToStories: scrollToStories,
                    scrollToPrograms: scrollToPrograms,
                    scrollToTeam: scrollToTeam,
                    scrollToContact: scrollToContact,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final VoidCallback scrollToHero;
  final VoidCallback scrollToStories;
  final VoidCallback scrollToPrograms;
  final VoidCallback scrollToTeam;
  final VoidCallback scrollToContact;

  const _MobileMenuButton({
    required this.scrollToHero,
    required this.scrollToStories,
    required this.scrollToPrograms,
    required this.scrollToTeam,
    required this.scrollToContact,
  });

  void _openFullScreenMenu(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => _FullScreenMenu(
          scrollToHero: scrollToHero,
          scrollToStories: scrollToStories,
          scrollToPrograms: scrollToPrograms,
          scrollToTeam: scrollToTeam,
          scrollToContact: scrollToContact,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                  .animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
      onPressed: () => _openFullScreenMenu(context),
    );
  }
}

class _FullScreenMenu extends StatefulWidget {
  final VoidCallback scrollToHero;
  final VoidCallback scrollToStories;
  final VoidCallback scrollToPrograms;
  final VoidCallback scrollToTeam;
  final VoidCallback scrollToContact;

  static const Color _lightGreen = Color(0xFFC8E6C9);

  const _FullScreenMenu({
    required this.scrollToHero,
    required this.scrollToStories,
    required this.scrollToPrograms,
    required this.scrollToTeam,
    required this.scrollToContact,
  });

  @override
  State<_FullScreenMenu> createState() => _FullScreenMenuState();
}

class _FullScreenMenuState extends State<_FullScreenMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;
  final List<String> _menuItems = ['Home', 'Stories', 'Programs', 'Team', 'Contact', 'Donate'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _slideAnimations = _menuItems.asMap().entries.map((entry) {
      final index = entry.key;
      return Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
          .animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeOut)));
    }).toList();

    _fadeAnimations = _menuItems.asMap().entries.map((entry) {
      final index = entry.key;
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeOut)));
    }).toList();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  VoidCallback _getCallback(String label) {
    switch (label) {
      case 'Home':
        return widget.scrollToHero;
      case 'Stories':
        return widget.scrollToStories;
      case 'Programs':
        return widget.scrollToPrograms;
      case 'Team':
        return widget.scrollToTeam;
      case 'Contact':
      case 'Donate':
      default:
        return widget.scrollToContact;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Frosted glass background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: _FullScreenMenu._lightGreen.withOpacity(0.85),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _menuItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final label = entry.value;
                      return SlideTransition(
                        position: _slideAnimations[index],
                        child: FadeTransition(
                          opacity: _fadeAnimations[index],
                          child: _AnimatedFullScreenMenuButton(
                            label: label,
                            onTap: () {
                              Navigator.of(context).pop();
                              _getCallback(label)();
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedFullScreenMenuButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _AnimatedFullScreenMenuButton({required this.label, required this.onTap});

  @override
  State<_AnimatedFullScreenMenuButton> createState() =>
      _AnimatedFullScreenMenuButtonState();
}

class _AnimatedFullScreenMenuButtonState
    extends State<_AnimatedFullScreenMenuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            color: _isPressed ? Colors.black12 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
