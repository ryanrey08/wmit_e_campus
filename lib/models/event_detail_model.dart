class EventDetailModel {
  final String id;
  final String schoolName;
  final String title;
  final String description;
  final String? category;
  final String? location;

  final DateTime startDate;
  final DateTime endDate;

  final DateTime? updatedAt;

  final List<String> attachments;

  EventDetailModel({
    required this.id,
    required this.schoolName,
    required this.title,
    required this.description,
    this.category,
    this.location,
    required this.startDate,
    required this.endDate,
    this.updatedAt,
    required this.attachments,
  });
}
