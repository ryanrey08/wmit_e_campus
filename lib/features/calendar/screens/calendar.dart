import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '/core/theme/app_theme.dart' show AppColors, AppTheme, AppGradients;
import '/features/calendar/widgets/calendar_filter_sheet.dart';
import '/models/calendar_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  bool isLoading = false;
  bool isOffline = false;

  CalendarFormat calendarFormat = CalendarFormat.month;

  final Set<CalendarItemType> activeTypes = {
    CalendarItemType.event,
    CalendarItemType.announcement,
    CalendarItemType.attendance,
  };

  final List<String> selectedSchools = [];

  final Map<DateTime, List<CalendarItem>> calendarItems = {};

  @override
  void initState() {
    super.initState();

    _loadCalendar();
  }

  Future<void> _loadCalendar() async {
    final now = DateTime.now();

    calendarItems.clear();

    calendarItems[now] = [
      CalendarItem(
        id: '1',
        type: CalendarItemType.announcement,
        title: '4th Grading Test',
        subtitle: '8 Feb 2025 - 20 Feb 2025',
        dateTime: now,
        isAllDay: true,
      ),
      CalendarItem(
        id: '2',
        type: CalendarItemType.event,
        title: 'School Mass',
        subtitle: 'Quadrangle, 8 Feb 2025 at 08:00AM',
        dateTime: now,
      ),
      CalendarItem(
        id: '3',
        type: CalendarItemType.attendance,
        title: 'Classes Start!',
        subtitle: '28 Feb, 2025',
        studentName: 'Juan Dela Cruz',
        direction: 'IN',
        dateTime: now,
      ),
    ];

    setState(() {});
  }

  List<CalendarItem> _itemsForDay(DateTime day) {
    return calendarItems.entries
        .where((entry) => isSameDay(entry.key, day))
        .expand((entry) => entry.value)
        .where((item) => activeTypes.contains(item.type))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: const Text(
      //     'School Calendar',
      //     style: TextStyle(
      //       fontFamily: AppTheme.themePoppins,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 24,
      //       color: Color(0xFF21242D),
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.today),
      //       onPressed: () {
      //         setState(() {
      //           selectedDay = DateTime.now();

      //           focusedDay = DateTime.now();
      //         });
      //       },
      //     ),
      //     PopupMenuButton<String>(
      //       onSelected: (value) {
      //         setState(() {
      //           switch (value) {
      //             case 'month':
      //               calendarFormat = CalendarFormat.month;
      //               break;

      //             case 'week':
      //               calendarFormat = CalendarFormat.week;
      //               break;

      //             case 'agenda':
      //               calendarFormat = CalendarFormat.twoWeeks;
      //               break;
      //           }
      //         });
      //       },
      //       itemBuilder: (_) => [
      //         const PopupMenuItem(value: 'month', child: Text('Month')),
      //         const PopupMenuItem(value: 'week', child: Text('Week')),
      //         const PopupMenuItem(value: 'agenda', child: Text('Agenda')),
      //       ],
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.filter_alt_outlined),
      //       onPressed: _showFilterSheet,
      //     ),
      //   ],
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.onboardingBackground,
        ),
        child: Column(
          children: [
            SizedBox(height: 60),
            const Text(
              'School Calendar',
              style: TextStyle(
                fontFamily: AppTheme.themePoppins,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color(0xFF21242D),
              ),
              textAlign: TextAlign.center,
            ),
            if (isOffline)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: AppColors.warning.withValues(alpha: .15),
                child: const Text('Offline — showing cached calendar'),
              ),

            TableCalendar<CalendarItem>(
              firstDay: DateTime.utc(2024),
              lastDay: DateTime.utc(2035),
              focusedDay: focusedDay,
              calendarFormat: calendarFormat,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                });
              },
              eventLoader: _itemsForDay,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) {
                    return const SizedBox();
                  }

                  final count = events.length;

                  return Positioned(
                    bottom: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        count > 3 ? '3+' : count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                },
              ),
              onDayLongPressed: (day, focusedDay) {
                _showPreview(day);
              },
            ),

            const Divider(height: 1),

            Expanded(child: _buildSelectedDayPanel()),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedDayPanel() {
    final items = _itemsForDay(selectedDay);

    if (items.isEmpty) {
      return const Center(
        child: Text('No events, announcements, or attendance on this day.'),
      );
    }

    items.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    final allDayEvents = items.where((e) => e.isAllDay).toList();

    final regularItems = items.where((e) => !e.isAllDay).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (allDayEvents.isNotEmpty) ...allDayEvents.map(_buildItemCard),

        ...regularItems.map(_buildItemCard),
      ],
    );
  }

  Widget _buildItemCard(CalendarItem item) {
    IconData icon;
    Color color;
    Color bColor;

    switch (item.type) {
      case CalendarItemType.event:
        icon = Icons.event;
        color = Color(0xFF767DFF);
        bColor = Color(0xFFF2EDFD);
        break;

      case CalendarItemType.announcement:
        icon = Icons.campaign_outlined;
        color = Color(0xFFFFB46D);
        bColor = Color(0xFFFEF1ED);
        break;

      case CalendarItemType.attendance:
        icon = Icons.badge;
        color = Color(0xFF5CD44F);
        bColor = Color(0xFFEFF9ED);
        break;
    }

    return Card(
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ), // Smooth, highly rounded corners
        side: BorderSide(
          color: color, // Subtle light border color
          width: 1,
        ),
      ),
      color: bColor, // Light background color based on type
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              item.dateTime.day.toString(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontFamily: AppTheme.themePoppins,
              ),
            ),
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: AppTheme.themePoppins,
            fontSize: 14,
            color: color,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.subtitle,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: AppTheme.themePoppins,
                fontSize: 12,
                color: color,
              ),
            ),
            // if (item.type == CalendarItemType.attendance)
            //   Text(
            //     '${item.direction} • ${TimeOfDay.fromDateTime(item.dateTime).format(context)}',
            //   ),
          ],
        ),
        onTap: () {
          switch (item.type) {
            case CalendarItemType.event:
              context.push('/event/${item.id}');
              break;

            case CalendarItemType.announcement:
              // Announcement Detail
              context.push('/announcements-detail/${item.id}');
              break;

            case CalendarItemType.attendance:
              // Student Attendance Page
              context.push('/student-attendance/${item.id}');
              break;
          }
        },
      ),
    );
  }

  void _showPreview(DateTime day) {
    final items = _itemsForDay(day);

    final events = items.where((e) => e.type == CalendarItemType.event).length;

    final announcements = items
        .where((e) => e.type == CalendarItemType.announcement)
        .length;

    final attendance = items
        .where((e) => e.type == CalendarItemType.attendance)
        .length;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${day.month}/${day.day}/${day.year}'),
        content: Text(
          '$events events\n'
          '$announcements announcements\n'
          '$attendance attendance',
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const CalendarFilterSheet(),
    );
  }
}
