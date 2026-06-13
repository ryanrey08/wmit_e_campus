import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart';

class ActivityItem {
  final String name;
  final String studentId;
  final String gate;
  final String date;
  final String time;

  ActivityItem({
    required this.name,
    required this.studentId,
    required this.gate,
    required this.date,
    required this.time,
  });
}

class ActivityCard extends StatelessWidget {
  final ActivityItem item;

  const ActivityCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFAFB3C1)),
        borderRadius: BorderRadius.circular(18),
        color: Color(0xFFAFB3C1).withOpacity(0.2),
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Color(0xFFAFB3C1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/login-01.svg',
                width: 18,
                height: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar/student1.jpg'),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontFamily: AppTheme.themePoppins,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  item.studentId,
                  style: const TextStyle(
                    color: Color(0xFFA3A3AE),
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    fontFamily: AppTheme.themePoppins,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.gate,
                style: TextStyle(
                  fontFamily: AppTheme.themePoppins,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  color: AppColors.black,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: item.date,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontFamily: AppTheme.themePoppins,
                        height: 1.0,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: item.time,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: AppTheme.themePoppins,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
