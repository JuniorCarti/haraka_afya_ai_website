import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';
import 'package:haraka_afya_ai_website/utils/responsive.dart';
import 'package:haraka_afya_ai_website/widgets/contact_info.dart';
import 'package:haraka_afya_ai_website/widgets/section_template.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: SectionTemplate(
        title: 'Get In Touch',
        subtitle: 'We\'d love to hear from you',
        child: SizedBox(
          width: isDesktop ? 1000 : 600,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: AppConstants.lightTextColor.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop) ...[
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
                          ContactInfo(
                            icon: Icons.email,
                            title: 'Email Us',
                            value: AppConstants.email,
                            color: AppConstants.primaryColor,
                          ),
                          const SizedBox(height: 20),
                          ContactInfo(
                            icon: Icons.phone,
                            title: 'Call Us',
                            value: AppConstants.phone,
                            color: AppConstants.secondaryColor,
                          ),
                          const SizedBox(height: 20),
                          ContactInfo(
                            icon: Icons.location_on,
                            title: 'Visit Us',
                            value: AppConstants.location,
                            color: AppConstants.accentColor,
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
                                onPressed: () => _launchUrl(AppConstants.facebookUrl),
                                icon: const FaIcon(FontAwesomeIcons.facebook),
                                color: AppConstants.primaryColor,
                              ),
                              IconButton(
                                onPressed: () => _launchUrl(AppConstants.twitterUrl),
                                icon: const FaIcon(FontAwesomeIcons.twitter),
                                color: AppConstants.primaryColor,
                              ),
                              IconButton(
                                onPressed: () => _launchUrl(AppConstants.instagramUrl),
                                icon: const FaIcon(FontAwesomeIcons.instagram),
                                color: AppConstants.primaryColor,
                              ),
                              IconButton(
                                onPressed: () => _launchUrl(AppConstants.linkedinUrl),
                                icon: const FaIcon(FontAwesomeIcons.linkedin),
                                color: AppConstants.primaryColor,
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
                            backgroundColor: AppConstants.primaryColor,
                            foregroundColor: Colors.white,
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
      ),
    );
  }

  void _launchUrl(String url) {
    // Implement URL launching
  }
}