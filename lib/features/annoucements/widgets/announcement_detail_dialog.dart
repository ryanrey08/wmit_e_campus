import 'package:flutter/material.dart';

class AnnouncementDetailDialog extends StatelessWidget {
  const AnnouncementDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: SizedBox(
        width: 420,
        height: 650,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                left: 12,
                right: 8,
                top: 8,
                bottom: 0,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              color: const Color(0xff2563EB),
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Announcement', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(
                    'PTA Meetings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Posted by: The Principal',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: const Text('''
Parent–Teacher Meeting Content Memo

Date: [Insert Date]
Time: [Insert Time]
Location: [Insert Location]

Dear Parent(s) Name(s),

I hope this message finds you well. I'm looking forward to our upcoming parent-teacher meeting to discuss your student's progress and overall experience in class.

Meeting Agenda:

1. Introduction & Overview
• Brief introduction and purpose of meeting
• Overview of student's learning journey

2. Academic Progress
• Review grades and assessments
• Areas for improvement

3. Next Steps
• Goals for the upcoming term
• Parent support recommendations

Thank you for your continued support.
                  ''', style: TextStyle(height: 1.6, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
