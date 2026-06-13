import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmit_e_campus/features/dashboard/widgets/activity_item.dart';
import 'package:wmit_e_campus/features/dashboard/widgets/quick_action_item.dart';
import '/features/dashboard/widgets/filter_sheet.dart';
import '/models/attendance_event_model.dart';

import '../../../core/theme/app_theme.dart';
import '../widgets/attendance_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> students = [
    'assets/avatar/student1.jpg',
    'assets/avatar/student2.jpg',
    'assets/avatar/student3.jpg',
    'assets/avatar/student4.jpg',
    'assets/avatar/student5.jpg',
  ];

  final List<ActivityItem> activities = [
    ActivityItem(
      name: 'Bo',
      studentId: 'STLMN-OP88',
      gate: 'LOGIN AT MAIN GATE',
      date: '08 Dec, 25',
      time: '08:00 AM',
    ),
    ActivityItem(
      name: 'Marry',
      studentId: 'STLMN-OP88',
      gate: 'LOGIN AT MAIN GATE',
      date: '08 Dec, 25',
      time: '08:00 AM',
    ),
  ];

  TextStyle get _filterTextStyle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF21242D),
    fontFamily: AppTheme.themePoppins,
    height: 16 / 24,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // bottomNavigationBar: const _DashboardBottomNav(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.onboardingBackground,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                _buildHeader(),

                const SizedBox(height: 40),

                _buildStudentsSection(),

                const SizedBox(height: 28),

                _buildAnnouncementCard(),

                const SizedBox(height: 28),

                _buildQuickActions(),

                const SizedBox(height: 32),

                const Text(
                  'Latest Activity',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTheme.themePoppins,
                  ),
                ),

                const SizedBox(height: 16),

                ...activities.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ActivityCard(item: e),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/avatar/profile_picture.jpg'),
          ),
        ),

        const SizedBox(width: 16),

        const Expanded(
          child: Text(
            'Monica!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: AppTheme.themePoppins,
              height: 16 / 32,
              color: AppColors.registerTitle,
            ),
          ),
        ),

        PopupMenuButton<String>(
          icon: const Icon(Icons.more_horiz),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          position: PopupMenuPosition.under,
          constraints: const BoxConstraints(minWidth: 250, maxWidth: 250),
          color: AppColors.white,
          onSelected: (value) {
            switch (value) {
              case 'edit':
                break;
              case 'notification':
                break;
              case 'help':
                break;
              case 'logout':
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'edit',
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Edit profile', style: _filterTextStyle),
                trailing: SvgPicture.asset(
                  'assets/icons/edit-02.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'notification',
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Notification', style: _filterTextStyle),
                trailing: SvgPicture.asset(
                  'assets/icons/notification-01.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'help',
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Help', style: _filterTextStyle),
                trailing: SvgPicture.asset(
                  'assets/icons/help-circle.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const PopupMenuItem(
              enabled: false,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              child: Divider(height: 1, thickness: 1, color: Color(0xFFE6E8EC)),
            ),
            PopupMenuItem<String>(
              value: 'logout',
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Log Out', style: _filterTextStyle),
                trailing: SvgPicture.asset(
                  'assets/icons/Logout.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudentsSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Students',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppTheme.themePoppins,
                  fontWeight: FontWeight.w300,
                  height: 16 / 24,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 42,
                child: Stack(
                  children: [
                    for (int i = 0; i < students.length; i++)
                      Positioned(
                        left: i * 24,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(students[i]),
                        ),
                      ),

                    Positioned(
                      left: students.length * 24,
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFEAEAEA),
                        child: Text('+5'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Column(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: AppColors.addButton,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.add),
            ),

            const SizedBox(height: 8),

            const Text('Add Student', style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/notification-02.svg',
                width: 27,
                height: 27,
              ),
            ),
          ),

          const SizedBox(width: 16),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Announcement',
                style: TextStyle(
                  color: AppColors.border,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppTheme.themePoppins,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'PTA Meeting on 18 Jan, 2025',
                style: TextStyle(
                  color: AppColors.border,
                  fontFamily: AppTheme.themePoppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.7,
      children: const [
        QuickActionItem(
          icon: 'assets/icons/calendar-02.svg',
          title: 'Calendar',
          color: Color(0xFFD3D5FE),
        ),
        QuickActionItem(
          icon: 'assets/icons/megaphone-01.svg',
          title: 'Announcement',
          color: Color(0xFFFFEFDA),
        ),
        QuickActionItem(
          icon: 'assets/icons/document-validation.svg',
          title: 'Attendance',
          color: Color(0xFFCFE5FC),
        ),
        QuickActionItem(
          icon: 'assets/icons/support.svg',
          title: 'Support',
          color: Color(0xFFFFE4F1),
        ),
      ],
    );
  }
}
