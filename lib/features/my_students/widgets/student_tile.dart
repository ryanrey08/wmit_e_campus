import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_theme.dart';
import '/models/my_students_model.dart';

class StudentTile extends StatelessWidget {
  final StudentSubscription student;
  final VoidCallback onRemove;

  const StudentTile({required this.student, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(student.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onRemove();
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.error,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(child: Text(student.studentName[0])),
        title: Text(student.studentName),
        subtitle: Text('${student.gradeLevel} • ${student.className}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              backgroundColor: student.notificationsEnabled
                  ? AppColors.success.withOpacity(.15)
                  : AppColors.greyLight,
              label: Text(
                student.notificationsEnabled
                    ? 'Notifications On'
                    : 'Notifications Off',
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          context.push('/student-attendance/${student.id}');
        },
      ),
    );
  }
}
