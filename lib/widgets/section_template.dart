import 'package:flutter/material.dart';

class SectionTemplate extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Gradient? gradient;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final CrossAxisAlignment crossAxisAlignment;

  const SectionTemplate({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.gradient,
    this.backgroundColor,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        gradient: gradient ??
            (backgroundColor != null
                ? LinearGradient(
                    colors: [backgroundColor!, backgroundColor!],
                  )
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.surface,
                      colorScheme.surface.withOpacity(0.9),
                    ],
                  )),
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: backgroundColor != null 
                    ? colorScheme.onPrimaryContainer 
                    : colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 18,
                color: backgroundColor != null
                    ? colorScheme.onPrimaryContainer.withOpacity(0.8)
                    : colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
          child,  // This is the child widget passed to the SectionTemplate
        ],
      ),
    );
  }
}