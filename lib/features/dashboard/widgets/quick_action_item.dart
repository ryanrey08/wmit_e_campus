import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart'
    show AppColors, AppTheme;

class QuickActionItem extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;

  const QuickActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: SvgPicture.asset(icon, width: 32, height: 32)),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.loginTitle,
            fontFamily: AppTheme.themePoppins,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
