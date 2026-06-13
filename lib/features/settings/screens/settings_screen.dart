import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/constants/app_constants.dart';
import '/core/theme/app_theme.dart' show AppColors;
import '/providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Notifications
  bool pushNotifications = true;

  final Map<String, bool> studentNotifications = {
    'Juan Dela Cruz': true,
    'Maria Santos': true,
  };

  final Map<String, bool> schoolAnnouncements = {
    'Acme School': true,
    'Westview Academy': true,
  };

  TimeOfDay quietStart = const TimeOfDay(hour: 22, minute: 0);

  TimeOfDay quietEnd = const TimeOfDay(hour: 6, minute: 0);

  // Dashboard
  double dashboardRecords = 15;

  // Calendar
  String calendarView = 'Month';

  bool showEvents = true;
  bool showAnnouncements = true;
  bool showAttendance = true;

  String firstDayOfWeek = 'Monday';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _sectionTitle('Notification Preferences'),

          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Live feed continues even when disabled'),
            value: pushNotifications,
            onChanged: (value) {
              setState(() {
                pushNotifications = value;
              });
            },
          ),

          ExpansionTile(
            title: const Text('Per Student Notifications'),
            children: studentNotifications.entries.map((entry) {
              return SwitchListTile(
                title: Text(entry.key),
                value: entry.value,
                onChanged: (value) {
                  setState(() {
                    studentNotifications[entry.key] = value;
                  });
                },
              );
            }).toList(),
          ),

          ExpansionTile(
            title: const Text('Announcement Notifications'),
            subtitle: const Text('Important/Urgent enabled by default'),
            children: schoolAnnouncements.entries.map((entry) {
              return SwitchListTile(
                title: Text(entry.key),
                value: entry.value,
                onChanged: (value) {
                  setState(() {
                    schoolAnnouncements[entry.key] = value;
                  });
                },
              );
            }).toList(),
          ),

          ListTile(
            title: const Text('Quiet Hours'),
            subtitle: Text(
              '${quietStart.format(context)} - ${quietEnd.format(context)}',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: _selectQuietHours,
          ),

          const ListTile(title: Text('Repeat'), subtitle: Text('Every day')),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Open System Notification Settings'),
            onTap: () {
              // open_app_settings
            },
          ),

          const Divider(),

          _sectionTitle('Dashboard Preferences'),

          ListTile(
            title: const Text('Records to show on Home'),
            subtitle: Text(dashboardRecords.round().toString()),
          ),

          Slider(
            value: dashboardRecords,
            min: 5,
            max: 50,
            divisions: 9,
            label: dashboardRecords.round().toString(),
            onChanged: (value) {
              setState(() {
                dashboardRecords = value;
              });
            },
          ),

          const Divider(),

          _sectionTitle('Calendar Preferences'),

          ListTile(
            title: const Text('Default View'),
            subtitle: Text(calendarView),
            onTap: _showCalendarViewPicker,
          ),

          SwitchListTile(
            title: const Text('Events'),
            value: showEvents,
            onChanged: (value) {
              setState(() {
                showEvents = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text('Announcements'),
            value: showAnnouncements,
            onChanged: (value) {
              setState(() {
                showAnnouncements = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text('Attendance'),
            value: showAttendance,
            onChanged: (value) {
              setState(() {
                showAttendance = value;
              });
            },
          ),

          ListTile(
            title: const Text('First Day of Week'),
            subtitle: Text(firstDayOfWeek),
            onTap: _showFirstDayPicker,
          ),

          const Divider(),

          _sectionTitle('Cache Management'),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Clear Cache For One Student'),
            onTap: _showStudentCacheDialog,
          ),

          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Clear Cached Attendance'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Clear Cached Announcements'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Clear Cached Calendar'),
            onTap: () {},
          ),

          const Divider(),

          _sectionTitle('Account'),

          const ListTile(
            title: Text('Email'),
            subtitle: Text('guardian@email.com'),
          ),

          const ListTile(
            title: Text('Phone'),
            subtitle: Text('+63 912 345 6789'),
          ),

          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            title: const Text('Change Phone Number'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: _showLogoutDialog,
          ),

          ListTile(
            title: const Text('Delete Account'),
            leading: const Icon(Icons.delete_forever, color: AppColors.error),
            textColor: AppColors.error,
            onTap: _showDeleteAccountDialog,
          ),

          const Divider(),

          _sectionTitle('About'),

          const ListTile(title: Text('Version'), subtitle: Text('1.0.0 (100)')),

          ListTile(title: const Text('Terms & Conditions'), onTap: () {}),

          ListTile(title: const Text('Privacy Policy'), onTap: () {}),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _selectQuietHours() async {
    final start = await showTimePicker(
      context: context,
      initialTime: quietStart,
    );

    if (start == null) return;

    final end = await showTimePicker(context: context, initialTime: quietEnd);

    if (end == null) return;

    setState(() {
      quietStart = start;
      quietEnd = end;
    });
  }

  void _showCalendarViewPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Month'),
                onTap: () {
                  setState(() {
                    calendarView = 'Month';
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              ListTile(
                title: const Text('Week'),
                onTap: () {
                  setState(() {
                    calendarView = 'Week';
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              ListTile(
                title: const Text('Agenda'),
                onTap: () {
                  setState(() {
                    calendarView = 'Agenda';
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFirstDayPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Sunday'),
                onTap: () {
                  setState(() {
                    firstDayOfWeek = 'Sunday';
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              ListTile(
                title: const Text('Monday'),
                onTap: () {
                  setState(() {
                    firstDayOfWeek = 'Monday';
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStudentCacheDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Student Cache'),
        content: const Text('Select a student cache to clear.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                logout();
              });
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void logout() async {
    ref.read(authProvider.notifier).logout();
    context.go('/login');
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
