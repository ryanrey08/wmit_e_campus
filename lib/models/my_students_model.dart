class StudentSubscription {
  final String id;
  final String studentName;
  final String className;
  final String gradeLevel;
  final String school;
  final bool notificationsEnabled;

  StudentSubscription({
    required this.id,
    required this.studentName,
    required this.className,
    required this.gradeLevel,
    required this.school,
    required this.notificationsEnabled,
  });
}
