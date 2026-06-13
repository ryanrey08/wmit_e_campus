class StudentAttendanceEvent {
  final String id;
  final String direction;
  final String accessPoint;
  final String site;
  final DateTime timestamp;

  StudentAttendanceEvent({
    required this.id,
    required this.direction,
    required this.accessPoint,
    required this.site,
    required this.timestamp,
  });
}
