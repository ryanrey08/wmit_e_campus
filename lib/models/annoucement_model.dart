class Announcement {
  final String id;
  final String schoolName;
  final String title;
  final String body;
  final DateTime publishedAt;
  final bool isRead;
  final bool isPinned;
  final String priority; // Normal, Important, Urgent

  Announcement({
    required this.id,
    required this.schoolName,
    required this.title,
    required this.body,
    required this.publishedAt,
    this.isRead = false,
    this.isPinned = false,
    this.priority = 'Normal',
  });
}
