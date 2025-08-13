import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';

class Responsive {
  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  
  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= AppConstants.mobileBreakpoint && 
      MediaQuery.of(context).size.width < AppConstants.tabletBreakpoint;
  
  static bool isDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;

  static double responsiveValue({
    required BuildContext context,
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? (mobile + desktop) / 2;
    return desktop;
  }
}