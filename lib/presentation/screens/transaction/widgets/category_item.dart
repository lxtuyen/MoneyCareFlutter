import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String percent;
  final IconData icon;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.title,
    required this.percent,
    required this.icon,
    this.isSelected = false,

  });

   @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 145,
      height: 105,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            percent,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
