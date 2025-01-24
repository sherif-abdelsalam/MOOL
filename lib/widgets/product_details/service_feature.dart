import 'package:flutter/material.dart';

class ServiceFeature extends StatelessWidget {
  const ServiceFeature({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: Color(0xff616161),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff616161),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ServiceFeatures extends StatelessWidget {
  const ServiceFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ServiceFeature(
              icon: Icons.check_circle_outline,
              title: 'Safe packaging',
              description: 'Orders are sanitized\nand packed',
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: Colors.grey.withAlpha(78),
          ),
          Expanded(
            child: ServiceFeature(
              icon: Icons.replay_outlined,
              title: 'Easy Return',
              description: '15 Days Easy Return',
            ),
          ),
        ],
      ),
    );
  }
}