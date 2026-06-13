import 'package:flutter/material.dart';

class AppColors {
  // Welcome / Onboarding Colors
  static const Color onboardingBackground = Color(0xFFFFFFFF);
  static const Color onboardingCard = Color(0xFF2367F5);
  static const Color onboardingPrimaryButton = Color(0xFFFFFFFF);
  static const Color onboardingPrimaryButtonText = Color(0xFF1A68FF);
  static const Color onboardingActiveDot = Color(0xFF458CFF);
  static const Color onboardingInactiveDot = Color(0xFFFFFFFF);
  static const Color onboardingTitle = Color(0xFFFFFFFF);
  static const Color onboardingSubtitle = Color(0xFFFFFFFF);

  //login
  static const Color loginBorder = Color(0xFFE5E7EB);
  static const Color loginHint = Color(0xFF9CA3AF);
  static const Color loginButtonDisabled = Color(0xFFAFC6FF);
  static const Color loginTitle = Color(0xFF21242D);
  static const Color loginLabel = Color(0xFF161C2B);
  static const Color required = Color(0xFFFC4A4A);

  //register
  static const Color registerTitle = Color(0xFF21242D);

  // Primary Colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);

  // Secondary Colors
  static const Color secondary = Color(0xFF03A9F4);
  static const Color secondaryLight = Color(0xFF4FC3F7);
  static const Color secondaryDark = Color(0xFF0288D1);

  // Accent Colors
  static const Color accent = Color(0xFF00BCD4);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color.fromRGBO(244, 67, 54, 1);
  static const Color info = Color(0xFF2196F3);

  // Order Status Colors
  static const Color statusPending = Color(0xFF9E9E9E);
  static const Color statusPlaced = Color(0xFF9E9E9E);
  static const Color statusConfirmed = Color(0xFF2196F3);
  static const Color statusPreparing = Color(0xFF9C27B0);
  static const Color statusAssigned = Color(0xFF9C27B0);
  static const Color statusOnTheWay = Color(0xFFFF9800);
  static const Color statusOutForDelivery = Color(0xFFFF9800);
  static const Color statusDelivered = Color(0xFF4CAF50);
  static const Color statusCancelled = Color(0xFFF44336);
  static const Color statusRefunded = Color(0xFF795548);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyMedium = Color(0xFF9E9E9E);
  static const Color greyDark = Color(0xFF616161);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFFAFAFA);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Role-specific Colors
  static const Color customerColor = Color(0xFF2196F3);
  static const Color driverColor = Color(0xFF4CAF50);
  static const Color ownerColor = Color(0xFF9C27B0);

  //hinText
  static const Color hinText = Color(0xFFA3A3AE);

  //checkbox
  static const Color checkBox = Color(0xFF141B34);

  //button
  static const Color button = Color(0xFF1A61F5);

  //dashboard
  static const Color addButton = Color(0xFFE4E6EA);
  static const Color border = Color(0xFF1A61F5);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.greyLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.greyLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );

  static const themePoppins = 'Poppins';
  static const themeRoboto = 'Roboto';
}

class AppGradients {
  static const LinearGradient onboardingBackground = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFEDF8FF), Color(0xFFFBECE1)],
    stops: [0.5253, 1.0],
  );
}
