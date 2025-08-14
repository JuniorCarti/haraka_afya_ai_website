import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/utils/responsive.dart';
import 'package:haraka_afya_ai_website/widgets/app_bar.dart';
import 'package:haraka_afya_ai_website/widgets/contact_section.dart';
import 'package:haraka_afya_ai_website/widgets/footer.dart';
import 'package:haraka_afya_ai_website/widgets/hero_section.dart';
import 'package:haraka_afya_ai_website/widgets/program_card.dart';
import 'package:haraka_afya_ai_website/widgets/section_template.dart';
import 'package:haraka_afya_ai_website/widgets/stat_card.dart';
import 'package:haraka_afya_ai_website/widgets/story_card.dart';
import 'package:haraka_afya_ai_website/widgets/team_member.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _storiesKey = GlobalKey();
  final _programsKey = GlobalKey();
  final _teamKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
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
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          HarakaAppBar(
            scrollToHero: () => _scrollTo(_heroKey),
            scrollToStories: () => _scrollTo(_storiesKey),
            scrollToPrograms: () => _scrollTo(_programsKey),
            scrollToTeam: () => _scrollTo(_teamKey),
            scrollToContact: () => _scrollTo(_contactKey),
          ),

          HeroSection(
            key: _heroKey,
            fadeAnimation: _fadeAnimation,
            scaleAnimation: _scaleAnimation,
            sectionKey: _heroKey,
          ),

          // About Section
          SliverToBoxAdapter(
            child: SectionTemplate(
              title: 'Our Mission',
              child: Column(
                children: [
                  SizedBox(
                    width: Responsive.isMobile(context) ? double.infinity : 800,
                    child: Text(
                      AppConstants.appDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.lightTextColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: AppConstants.stats.entries
                        .map<Widget>((entry) => StatCard(
                              value: entry.value,
                              label: entry.key,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          // Stories Section
          SliverToBoxAdapter(
            key: _storiesKey,
            child: SectionTemplate(
              title: 'Patient Stories',
              subtitle: 'Real journeys — resilience, support, and hope.',
              backgroundColor: AppConstants.secondaryColor.withOpacity(0.1),
              child: SizedBox(
                width: Responsive.isMobile(context) ? double.infinity : 1200,
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: AppConstants.stories
                      .map<Widget>((story) => StoryCard(
                            title: story['title']!,
                            excerpt: story['excerpt']!,
                            imageUrl: story['image']!,
                            onTap: () => _showStoryModal(context, story),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          // Programs Section
          SliverToBoxAdapter(
            key: _programsKey,
            child: SectionTemplate(
              title: 'Our Programs & Services',
              child: SizedBox(
                width: Responsive.isMobile(context) ? double.infinity : 1200,
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: AppConstants.programs
                      .map<Widget>((program) => ProgramCard(
                            icon: program['icon'] as IconData,
                            title: program['title'] as String,
                            description: program['description'] as String,
                            color: program['color'] as Color,
                            imageUrl: program['imageUrl'] as String, // ✅ Added
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          // Team Section
          SliverToBoxAdapter(
            key: _teamKey,
            child: SectionTemplate(
              title: 'Meet Our Team',
              subtitle:
                  'Passionate professionals dedicated to making a difference',
              backgroundColor: AppConstants.secondaryColor.withOpacity(0.1),
              child: SizedBox(
                width: Responsive.isMobile(context) ? double.infinity : 1200,
                child: Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  alignment: WrapAlignment.center,
                  children: AppConstants.teamMembers
                      .map<Widget>((member) => TeamMember(
                            name: member['name']!,
                            role: member['role']!,
                            imageUrl: member['image']!,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          // Contact Section
          ContactSection(key: _contactKey),

          // Footer
          const Footer(),
        ],
      ),
    );
  }

  void _showStoryModal(BuildContext context, Map<String, String> story) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  story['image']!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                story['title']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                story['excerpt']!,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.lightTextColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Full story content would go here with more details about the patient\'s journey, how Haraka Afya helped, and their current status. This is just a placeholder for the demo.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
