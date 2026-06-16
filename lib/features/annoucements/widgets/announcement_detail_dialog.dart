import 'package:flutter/material.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart';

class AnnouncementDetailDialog extends StatelessWidget {
  const AnnouncementDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 700),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.campaign_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.18),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'SCHOOL ANNOUNCEMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppTheme.themePoppins,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'PTA Meetings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppTheme.themePoppins,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Posted by: The Principal',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: AppTheme.themePoppins,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: AppTheme.themePoppins,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          '''
Parent–Teacher Meeting Content Memo

Date: June 20, 2026
Time: 9:00 AM
Location: School Conference Hall

Dear Parents,

We are pleased to invite you to our upcoming Parent–Teacher Meeting. This meeting will provide an opportunity to discuss your child's academic progress, classroom participation, and future goals.

Meeting Agenda

1. Introduction & Overview
• Welcome remarks
• Review of current academic period

2. Academic Progress
• Grades and assessments
• Areas for improvement
• Student achievements

3. Parent Collaboration
• Home learning support
• Communication channels

4. Goals & Next Steps
• Upcoming projects
• Action plans for success

Thank you for your continued partnership and support in your child's education.

We look forward to meeting with you.
                          ''',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.8,
                            color: Color(0xFF334155),
                            fontFamily: AppTheme.themePoppins,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // FOOTER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      label: const Text(
                        'Share',
                        style: TextStyle(fontFamily: AppTheme.themePoppins),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.check),
                      label: const Text(
                        'Mark as Read',
                        style: TextStyle(fontFamily: AppTheme.themePoppins),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
