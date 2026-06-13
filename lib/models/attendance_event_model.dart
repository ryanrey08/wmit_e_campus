class AttendanceEvent {
  final String id;
  final String studentName;
  final String gradeLevel;
  final String className;
  final String direction;
  final String accessPoint;
  final String site;
  final String school;
  final DateTime timestamp;
  final bool unread;

  AttendanceEvent({
    required this.id,
    required this.studentName,
    required this.gradeLevel,
    required this.className,
    required this.direction,
    required this.accessPoint,
    required this.site,
    required this.school,
    required this.timestamp,
    this.unread = false,
  });
}
