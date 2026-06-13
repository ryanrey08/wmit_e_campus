import 'package:flutter/material.dart';
import '/core/theme/app_theme.dart' show AppColors;

class PriorityBadge extends StatelessWidget {
  final String priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (priority) {
      case 'Urgent':
        color = AppColors.error;
        break;

      case 'Important':
        color = AppColors.warning;
        break;

      default:
        color = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        priority,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
