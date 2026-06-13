import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_theme.dart' show AppColors;
import '/features/student_attendance/widgets/attendance_filter_sheet.dart';
import '/models/student_attendance_event_model.dart';
import '/models/student_details_model.dart';

// import '../../../core/theme/app_theme.dart';

class StudentAttendanceScreen extends StatefulWidget {
  final String studentId;

  const StudentAttendanceScreen({super.key, required this.studentId});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  bool isOffline = false;
  bool isLocked = false;
  bool isPaginating = false;

  StudentDetails student = StudentDetails(
    id: '1',
    name: 'Juan Dela Cruz',
    className: 'Section A',
    gradeLevel: 'Grade 6',
    schoolName: 'Acme School',
    notificationsEnabled: true,
  );

  List<StudentAttendanceEvent> events = [];

  @override
  void initState() {
    super.initState();

    _loadCached14Days();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 300) {
        _loadOlderHistory();
      }
    });
  }

  Future<void> _loadCached14Days() async {
    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      events = _dummyEvents();
    });
  }

  Future<void> _refreshAttendance() async {
    // refresh replaces cached window

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      events = _dummyEvents();
    });
  }

  Future<void> _loadOlderHistory() async {
    if (isPaginating) return;

    setState(() {
      isPaginating = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      events.addAll(_dummyEvents());
    } finally {
      if (mounted) {
        setState(() {
          isPaginating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return _buildLockedState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: _showFilterSheet,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh to pick up corrections',
            onPressed: _refreshAttendance,
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Notifications'),
                onTap: _showNotificationToggle,
              ),
              PopupMenuItem(
                child: const Text('Clear Cache'),
                onTap: _clearCache,
              ),
              PopupMenuItem(
                child: const Text('Unsubscribe'),
                onTap: _unsubscribe,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (isOffline)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.warning.withOpacity(.15),
              child: const Text(
                'Showing cached 14 days. Connect to load older.',
              ),
            ),

          _buildHeader(),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAttendance,
              child: events.isEmpty ? _buildEmptyState() : _buildTimeline(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final initials = student.name.split(' ').map((e) => e[0]).take(2).join();

    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface,
      child: Row(
        children: [
          CircleAvatar(radius: 28, child: Text(initials)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${student.gradeLevel} • ${student.className}'),
                Text(student.schoolName),
              ],
            ),
          ),
          Chip(
            label: Text(
              student.notificationsEnabled
                  ? 'Notifications On'
                  : 'Notifications Off',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final grouped = _groupByDay();

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: grouped.keys.length + 1,
      itemBuilder: (context, index) {
        if (index == grouped.keys.length) {
          return isPaginating
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox();
        }

        final date = grouped.keys.elementAt(index);

        final dayEvents = grouped[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 16),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...dayEvents.map(_buildEventTile),
          ],
        );
      },
    );
  }

  Widget _buildEventTile(StudentAttendanceEvent event) {
    final isIn = event.direction == 'IN';

    return Card(
      child: ListTile(
        leading: Chip(
          backgroundColor: isIn ? AppColors.success : AppColors.warning,
          label: Text(
            event.direction,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(event.accessPoint),
        subtitle: Text(event.site),
        trailing: Text(TimeOfDay.fromDateTime(event.timestamp).format(context)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: const [
        SizedBox(height: 120),
        Center(
          child: Column(
            children: [
              Icon(Icons.history, size: 72),
              SizedBox(height: 16),
              Text('No attendance records yet.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLockedState() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 96, color: Colors.grey.shade400),
              const SizedBox(height: 24),
              Text(
                student.name,
                style: TextStyle(fontSize: 24, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 16),
              const Text(
                'This subscription has been revoked.\nContact the school to renew.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AttendanceFilterSheet(),
    );
  }

  void _showNotificationToggle() {}

  void _clearCache() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Remove cached attendance records?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              setState(() {
                events.clear();
              });
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _unsubscribe() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Unsubscribe'),
        content: const Text(
          'Stop receiving attendance updates for this student?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              context.go('/my-students');
            },
            child: const Text('Unsubscribe'),
          ),
        ],
      ),
    );
  }

  Map<String, List<StudentAttendanceEvent>> _groupByDay() {
    final map = <String, List<StudentAttendanceEvent>>{};

    for (final event in events) {
      final key =
          '${event.timestamp.year}-${event.timestamp.month}-${event.timestamp.day}';

      map.putIfAbsent(key, () => []);

      map[key]!.add(event);
    }

    return map;
  }

  List<StudentAttendanceEvent> _dummyEvents() {
    return List.generate(
      15,
      (index) => StudentAttendanceEvent(
        id: '$index',
        direction: index.isEven ? 'IN' : 'OUT',
        accessPoint: 'Main Gate',
        site: 'North Campus',
        timestamp: DateTime.now().subtract(Duration(hours: index * 2)),
      ),
    );
  }
}
