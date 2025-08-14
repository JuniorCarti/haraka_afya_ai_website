import 'package:flutter/material.dart';

class AppConstants {
  // Design Constants
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  
  // Colors
  static const Color primaryColor = Color(0xFF006D77);
  static const Color secondaryColor = Color(0xFF83C5BE);
  static const Color accentColor = Color(0xFFEDF6F9);
  static const Color textColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFF777777);

  // Content
  static const String appTitle = 'Haraka Afya';
  static const String appSubtitle = 'Cancer Support Trust';
  static const String appDescription = 'Supporting patients and families through cancer care, awareness & early detection.';
  
  // URLs
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.example.haraka_afya';
  static const String appStoreUrl = 'https://apps.apple.com/app/idXXXXXXXXX';
  static const String donationUrl = 'https://example.org/donate';
  
  // Contact
  static const String email = 'info@harakaafya.org';
  static const String phone = '+254 745 8432 29';
  static const String location = 'Nairobi, Kenya';
  
  // Social Media
  static const String facebookUrl = 'https://facebook.com/harakaafya';
  static const String twitterUrl = 'https://twitter.com/harakaafya';
  static const String instagramUrl = 'https://instagram.com/harakaafya';
  static const String linkedinUrl = 'https://linkedin.com/company/harakaafya';
  
  // Stats
  static const Map<String, String> stats = {
    'Patients Supported': '2,500+',
    'Community Programs': '15+',
    'Satisfaction Rate': '98%',
    'Trained Volunteers': '50+',
  };
  
  // Team Members
  static const List<Map<String, String>> teamMembers = [
    {
      'name': 'Ridge Junior Abuto',
      'role': 'Founder & CEO',
      'image': 'https://images.unsplash.com/photo-1745163190343-fe6f1a3aaa1c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTZ8fG1lbiUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D'
    },
    {
      'name': 'Samuel Otieno',
      'role': 'Community Lead',
      'image': 'https://images.unsplash.com/photo-1662638035662-455f32fd02ad?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzJ8fG1lbiUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D'
    },
    {
      'name': 'Joy Mutanu',
      'role': 'Co-Founder',
      'image': 'https://images.unsplash.com/photo-1611417361507-7d77bbc20a73?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjR8fHdvbWVuJTIwaW1hZ2VzfGVufDB8fDB8fHww'
    }
  ];
  
  // Programs
  static const List<Map<String, dynamic>> programs = [
    {
      'icon': Icons.health_and_safety,
      'title': 'Screening & Education',
      'description': 'Community screening events & health education',
      'color': primaryColor,
      'imageUrl': 'https://plus.unsplash.com/premium_photo-1673958771882-df5e5765b146?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8c2NyZWVuaW5nfGVufDB8fDB8fHww',
    },
    {
      'icon': Icons.psychology,
      'title': 'Counselling',
      'description': 'One-on-one emotional & psychological support',
      'color': secondaryColor,
      'imageUrl': 'https://images.unsplash.com/photo-1573495804664-b1c0849525af?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGNvdW5zZWxsaW5nfGVufDB8fDB8fHww',
    },
    {
      'icon': Icons.group,
      'title': 'Support Groups',
      'description': 'Peer support & survivor networks',
      'color': Color(0xFFFFDDD2),
      'imageUrl': 'https://images.unsplash.com/photo-1655720358066-2aab2a903ef8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c3VwcG9ydCUyMGdyb3Vwc3xlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'icon': Icons.favorite,
      'title': 'Financial Assistance',
      'description': 'Support for treatment costs & transport',
      'color': Color(0xFFE29578),
      'imageUrl': 'https://images.unsplash.com/photo-1579460372796-3aa720f44e46?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDJ8fGZpbmFuY2lhbCUyMGFzc2lhdGFuY2V8ZW58MHx8MHx8fDA%3D',
    },
  ];
  
  // Stories
  static const List<Map<String, String>> stories = [
    {
      'title': 'Grace\'s Journey',
      'excerpt': 'After early screening Grace received timely treatment and is now mentoring others.',
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': 'John\'s Story',
      'excerpt': 'John found community support and financial help that kept his treatment going.',
      'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': 'Aisha\'s Recovery',
      'excerpt': 'Aisha\'s early diagnosis saved her life — now she volunteers with Haraka Afya.',
      'image': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=1588&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
  ];
}