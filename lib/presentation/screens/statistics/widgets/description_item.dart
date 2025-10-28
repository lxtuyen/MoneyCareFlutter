import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({
    super.key,
    required this.title,
    required this.value,
    required this.percent,
    required this.percentColor,
    required this.icon,
  });

  final String title;
  final String value;
  final String percent;
  final Color percentColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Icon(icon, color: percentColor, size: 20),
            Text(
              percent,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: percentColor,
              ),
            ),
          ],
        ),

        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Divider(height: 16, thickness: 1, color: Color(0xFFE0E0E0)),
        ),
      ],
    );
  }
}
