import 'package:flutter/material.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart';

class AnnouncementCard extends StatelessWidget {
  final VoidCallback onTap;

  const AnnouncementCard({super.key, required this.onTap});

  TextStyle get titleStyle => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: Color(0xFFA3A3AE),
    fontFamily: AppTheme.themePoppins,
    height: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFAFB3C1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text('Announcement Title:', style: titleStyle)),
              Text('Date Posted: 03/10/2024', style: titleStyle),
            ],
          ),

          // const SizedBox(height: 10),
          Row(
            children: const [
              Expanded(
                child: Text(
                  'PTA Meeting on May 5, 2025',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppTheme.themePoppins,
                  ),
                ),
              ),
            ],
          ),

          // const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: Text('STLMN-OP88', style: titleStyle)),
              TextButton(
                onPressed: onTap,
                child: Text('Read More', style: titleStyle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
