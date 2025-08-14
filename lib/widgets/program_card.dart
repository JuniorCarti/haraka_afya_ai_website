import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';

class ProgramCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final String imageUrl; // new: background image URL

  const ProgramCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.imageUrl,
  });

  @override
  State<ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()
              ..scale(1.05)
              ..translate(0.0, -8.0))
            : Matrix4.identity(),
        child: SizedBox(
          width: 280,
          height: 320,
          child: Card(
            elevation: _isHovered ? 12 : 0,
            shadowColor: _isHovered
                ? widget.color.withOpacity(0.6)
                : Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: _isHovered
                    ? widget.color
                    : AppConstants.lightTextColor.withOpacity(0.1),
                width: 2,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Semi-transparent overlay for readability
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    color: Colors.black.withOpacity(_isHovered ? 0.35 : 0.5),
                  ),
                ),
                // Card content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.85),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.icon,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
