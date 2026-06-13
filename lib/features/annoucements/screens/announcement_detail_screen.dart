import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/models/annoucement_detail_model.dart';
import '../widgets/full_screen_image_viewer.dart';

import '../../../core/theme/app_theme.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final String announcementId;

  const AnnouncementDetailScreen({super.key, required this.announcementId});

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  bool isLoading = true;
  bool hasError = false;
  bool isOffline = false;

  bool markUnread = false;

  static bool _externalLinkPromptShown = false;

  AnnouncementDetailModel? announcement;

  @override
  void initState() {
    super.initState();

    _loadAnnouncement();

    Future.delayed(const Duration(seconds: 5), _markReadOnBackend);
  }

  Future<void> _loadAnnouncement() async {
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      isLoading = false;

      announcement = AnnouncementDetailModel(
        id: '1',
        schoolName: 'Acme School',
        title: 'PTA Meeting This Friday',
        bodyHtml: '''
<p>Dear Parents and Guardians,</p>

<p>
We invite you to attend our upcoming
<b>PTA Meeting</b>.
</p>

<ul>
<li>Academic Updates</li>
<li>School Activities</li>
<li>Student Welfare Programs</li>
</ul>

<p>
Visit
<a href="https://school.example.com">
our website
</a>
for more details.
</p>
''',
        publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        priority: 'Important',
        attachments: [
          'https://picsum.photos/800/500',
          'https://picsum.photos/700/400',
        ],
        isRead: true,
      );
    });
  }

  Future<void> _markReadOnBackend() async {
    debugPrint('Mark announcement as read');
  }

  Future<void> _refresh() async {
    await _loadAnnouncement();
  }

  Future<void> _handleLinkTap(String url) async {
    if (!_externalLinkPromptShown) {
      final proceed =
          await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Open External Link'),
              content: const Text('You are leaving the app.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ) ??
          false;

      if (!proceed) return;

      _externalLinkPromptShown = true;
    }

    launchUrl(Uri.parse(url));
  }

  void _shareAnnouncement() {
    if (announcement == null) return;

    final preview = announcement!.bodyHtml
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .substring(0, 200);

    Share.share(
      '${announcement!.title}\n\n$preview...\n\n'
      'tna://announcement/${announcement!.id}',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoading();
    }

    if (hasError) {
      return _buildError();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Announcement Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareAnnouncement,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (isOffline)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Offline — showing cached announcement'),
              ),

            _buildHeader(),

            const SizedBox(height: 20),

            Text(
              announcement!.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Html(
              data: announcement!.bodyHtml,
              onLinkTap: (url, _, __) {
                if (url != null) {
                  _handleLinkTap(url);
                }
              },
            ),

            const SizedBox(height: 24),

            if (announcement!.attachments.isNotEmpty) _buildAttachments(),

            const SizedBox(height: 24),

            SwitchListTile(
              title: const Text('Mark as unread'),
              value: markUnread,
              onChanged: (value) {
                setState(() {
                  markUnread = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                announcement!.schoolName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (announcement!.priority != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  announcement!.priority!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          announcement!.publishedAt.toString(),
          style: const TextStyle(color: AppColors.textSecondary),
        ),

        if (announcement!.updatedAt != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Updated: ${announcement!.updatedAt}',
              style: const TextStyle(color: AppColors.info),
            ),
          ),
      ],
    );
  }

  Widget _buildAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attachments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: announcement!.attachments.map((imageUrl) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImageViewer(imageUrl: imageUrl),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 140,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 140,
                  height: 100,
                  color: Colors.grey.shade200,
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 140,
                  height: 100,
                  color: Colors.grey.shade300,
                  child: const Center(child: Text('Retry')),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcement')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError() {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcement')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 12),
            const Text('This announcement is no longer available.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadAnnouncement,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
