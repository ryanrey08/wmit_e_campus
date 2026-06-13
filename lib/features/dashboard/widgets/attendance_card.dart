import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_theme.dart';
import '/models/attendance_event_model.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceEvent event;

  const AttendanceCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isIn = event.direction == 'IN';

    return InkWell(
      onTap: () {
        context.push('/student-attendance/${event.id}');
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Timestamp'),
            content: Text(event.timestamp.toIso8601String()),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: event.unread
              ? const Border(
                  left: BorderSide(width: 5, color: AppColors.primary),
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Text(event.studentName.substring(0, 1))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.studentName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${event.gradeLevel} • ${event.className}'),
                      ],
                    ),
                  ),
                  Chip(
                    backgroundColor: isIn
                        ? AppColors.success
                        : AppColors.warning,
                    label: Text(
                      event.direction,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(event.accessPoint),

              Text(
                '${event.site} • ${event.school}',
                style: const TextStyle(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 8),

              Text(
                _relativeTime(event.timestamp),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _relativeTime(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) {
      return 'Just now';
    }

    if (diff.inHours < 1) {
      return '${diff.inMinutes} min ago';
    }

    return '${diff.inHours} hr ago';
  }
}
