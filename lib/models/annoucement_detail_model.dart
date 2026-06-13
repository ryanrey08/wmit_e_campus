class AnnouncementDetailModel {
  final String id;
  final String schoolName;
  final String title;
  final String bodyHtml;
  final DateTime publishedAt;
  final DateTime? updatedAt;
  final String? priority;
  final List<String> attachments;
  final bool isRead;

  AnnouncementDetailModel({
    required this.id,
    required this.schoolName,
    required this.title,
    required this.bodyHtml,
    required this.publishedAt,
    this.updatedAt,
    this.priority,
    required this.attachments,
    required this.isRead,
  });
}
