import 'package:flutter/material.dart';
import 'package:haraka_afya_ai_website/utils/constants.dart';

class TeamMember extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const TeamMember({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppConstants.primaryColor.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          role,
          style: TextStyle(
            fontSize: 16,
            color: AppConstants.lightTextColor,
          ),
        ),
      ],
    );
  }
}