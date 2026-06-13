enum CalendarItemType { event, announcement, attendance }

class CalendarItem {
  final String id;
  final CalendarItemType type;

  final String title;
  final String subtitle;

  final DateTime dateTime;

  final String? description;
  final String? location;

  final String? studentName;
  final String? direction;

  final bool isAllDay;

  CalendarItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    this.description,
    this.location,
    this.studentName,
    this.direction,
    this.isAllDay = false,
  });
}
