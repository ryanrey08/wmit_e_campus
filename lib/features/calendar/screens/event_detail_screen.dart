import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/core/theme/app_theme.dart' show AppColors;
import '/features/calendar/widgets/image_viewer.dart';
import '/models/event_detail_model.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool _loading = true;
  bool _error = false;
  bool _offline = false;

  bool _showUpdatedHint = true;

  static bool _linkPromptShown = false;

  EventDetailModel? _event;

  @override
  void initState() {
    super.initState();

    _loadEvent();
  }

  Future<void> _loadEvent() async {
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _loading = false;

      _event = EventDetailModel(
        id: '1',
        schoolName: 'Acme School',
        title: 'PTA General Assembly',
        category: 'PTA',
        location: '123 Main Street, Laguna, Philippines',
        startDate: DateTime.now().add(const Duration(days: 2)),
        endDate: DateTime.now().add(const Duration(days: 2, hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
        description: '''
<p><b>Parents and Guardians</b> are invited to attend.</p>

<ul>
<li>Academic updates</li>
<li>Student welfare programs</li>
<li>School improvements</li>
</ul>

<p>
Visit
<a href="https://school.example.com">
our website
</a>
for more details.
</p>
''',
        attachments: ['https://picsum.photos/800/500'],
      );
    });
  }

  Future<void> _refresh() async {
    await _loadEvent();
  }

  void _shareEvent() {
    if (_event == null) return;

    Share.share(
      '${_event!.title}\n'
      '${_event!.startDate}\n'
      '${_event!.location ?? ""}',
    );
  }

  void _addToCalendar() {
    if (_event == null) return;

    final event = Event(
      title: _event!.title,
      description: _event!.description,
      location: _event!.location,
      startDate: _event!.startDate,
      endDate: _event!.endDate,
    );

    Add2Calendar.addEvent2Cal(event);
  }

  Future<void> _openLocation() async {
    if (_event?.location == null) return;

    final query = Uri.encodeComponent(_event!.location!);

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );

    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _handleExternalLink(String url) async {
    if (!_linkPromptShown) {
      final proceed =
          await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Open External Link'),
              content: const Text('You are leaving the app.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ) ??
          false;

      if (!proceed) return;

      _linkPromptShown = true;
    }

    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _loadingState();
    }

    if (_error) {
      return _errorState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareEvent),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_offline) _offlineBanner(),

            _header(),

            const SizedBox(height: 20),

            Text(
              _event!.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _dateTimeCard(),

            const SizedBox(height: 16),

            if (_event!.location != null) _locationCard(),

            const SizedBox(height: 24),

            Html(
              data: _event!.description,
              onLinkTap: (url, _, __) {
                if (url != null) {
                  _handleExternalLink(url);
                }
              },
            ),

            if (_event!.attachments.isNotEmpty) _attachments(),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _addToCalendar,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Add To My Phone Calendar'),
            ),

            if (_event!.updatedAt != null)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'This event was updated. Re-add to your phone calendar to sync.',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _event!.schoolName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        if (_event!.category != null) Chip(label: Text(_event!.category!)),
      ],
    );
  }

  Widget _dateTimeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Start', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_event!.startDate.toString()),
            const SizedBox(height: 12),
            const Text('End', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_event!.endDate.toString()),
            const SizedBox(height: 8),
            const Text(
              '(School Time)',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationCard() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.place),
        title: Text(_event!.location!),
        subtitle: const Text('Open in Maps'),
        onTap: _openLocation,
      ),
    );
  }

  Widget _attachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Attachments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _event!.attachments
              .map(
                (url) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageViewer(imageUrl: url),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: 150,
                    height: 110,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      width: 150,
                      height: 110,
                      alignment: Alignment.center,
                      color: Colors.grey.shade300,
                      child: TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text('Retry'),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _offlineBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text('Offline — showing cached event'),
    );
  }

  Widget _loadingState() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _errorState() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.event_busy, size: 72),
            const SizedBox(height: 12),
            const Text('This event is no longer available.'),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _loadEvent, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
