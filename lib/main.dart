import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  // Remove this in production - just for demo animations
  timeDilation = 1.5;
  runApp(const HarakaAfyaWebsite());
}
