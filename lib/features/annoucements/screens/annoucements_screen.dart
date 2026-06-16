import 'package:flutter/material.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart';
import 'package:wmit_e_campus/features/annoucements/widgets/announcement_card.dart';
import 'package:wmit_e_campus/features/annoucements/widgets/announcement_detail_dialog.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent, // Keeps the top clean and flat
      //   elevation: 0, // Removes the default drop shadow
      //   // 1. Customize the Back Button
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back, // Standard material back arrow
      //       color: Color(
      //         0xFF1E2229,
      //       ), // Deep dark slate grey matching your screenshot
      //       size: 28,
      //     ),
      //     onPressed: () {
      //       Navigator.maybePop(
      //         context,
      //       ); // Safely pops back to the previous screen
      //     },
      //   ),

      //   // 2. Reduce spacing between the back arrow and title
      //   titleSpacing: 0,

      //   // 3. Style the Title
      //   title: const Text(
      //     'Announcements',
      //     style: TextStyle(
      //       fontFamily: AppTheme.themePoppins,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 24,
      //       color: Color(0xFF21242D),
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.onboardingBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: const Text(
                  'Announcements',
                  style: TextStyle(
                    fontFamily: AppTheme.themePoppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color(0xFF21242D),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '2024',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppTheme.themePoppins,
                            color: Color(0xFF21242D),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'February',
                          style: TextStyle(
                            color: Color(0XFF757C8E),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppTheme.themePoppins,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: const Color(0xffEEF1F5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("Create Event"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                'Latest',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF21242D),
                  fontFamily: AppTheme.themePoppins,
                ),
              ),

              const SizedBox(height: 16),

              ...List.generate(
                2,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AnnouncementCard(
                    onTap: () => _showAnnouncementDialog(context),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Last 7 Days',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF21242D),
                  fontFamily: AppTheme.themePoppins,
                ),
              ),

              const SizedBox(height: 16),

              ...List.generate(
                2,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AnnouncementCard(
                    onTap: () => _showAnnouncementDialog(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _showAnnouncementDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) {
        return const AnnouncementDetailDialog();
      },
    );
  }
}
