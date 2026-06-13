import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart' show AppColors;

import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

// Auth screens
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/register_step1_screen.dart';
import '../../features/auth/screens/register_step2_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';

//Main Screens
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/my_students/screen/my_students_screen.dart';
import '../../features/subscription/screens/add_subscription_screen.dart';
import '../../features//student_attendance/screens/student_attendance_screen.dart';
import '../../features/annoucements/screens/annoucements_screen.dart';
import '../../features/annoucements/screens/announcement_detail_screen.dart';
import '../../features//calendar/screens/calendar.dart';
import '../../features//settings/screens/settings_screen.dart';
import '../../features//calendar/screens/event_detail_screen.dart';

// Route names
class AppRoutes {
  // Auth routes
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const register1 = '/register1';
  static const register2 = '/register2';
  static const forgotPassword = '/forgotpassword';

  // Customer routes
  static const dashboard = '/dashboard';
  static const myStudents = '/my-students';
  static const addSubscription = '/add-subscription';
  static const studentAttendance = '/student-attendance/:studentId';
  static const announcements = '/announcements';
  static const announcementsDetail = '/announcements-detail/:announcementId';
  static const calendar = '/calendar';
  static const event = '/event/:eventId';
  static const settings = '/settings';
  static const customerHome = '/customer/home';
  static const customerOrders = '/customer/orders';
  static const customerProfile = '/customer/profile';
  static const editProfile = '/customer/profile/edit';
  static const stationList = '/customer/stations';
  static const stationDetail = '/customer/stations/:stationId';
  static const cart = '/customer/cart';
  static const checkout = '/customer/checkout';
  static const orderTracking = '/customer/orders/:orderId';
  static const addressManagement = '/customer/addresses';

  // Driver routes
  static const driverHome = '/driver/home';
  static const driverDeliveries = '/driver/deliveries';
  static const driverEarnings = '/driver/earnings';
  static const driverProfile = '/driver/profile';
  static const driverEditProfile = '/driver/profile/edit';
  static const driverVehicleInfo = '/driver/profile/vehicle';
  static const driverWorkSchedule = '/driver/work/schedule';
  static const driverServiceAreas = '/driver/work/areas';
  static const driverDeliveryHistory = '/driver/work/history';
  static const deliveryDetail = '/driver/deliveries/:orderId';

  // Owner routes
  static const ownerDashboard = '/owner/dashboard';
  static const ownerOrders = '/owner/orders';
  static const ownerAnalytics = '/owner/analytics';
  static const ownerDrivers = '/owner/drivers';
  static const ownerInventory = '/owner/inventory';
  static const ownerPromos = '/owner/promos';
  static const ownerSettings = '/owner/settings';
  static const ownerProducts = '/owner/products';
}

// Auth state notifier for router refresh
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(Ref ref) {
    ref.listen(authProvider, (_, __) {
      notifyListeners();
    });
  }
}

final authChangeNotifierProvider = Provider<AuthChangeNotifier>((ref) {
  return AuthChangeNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authChangeNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggingIn =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register1 ||
          state.matchedLocation == AppRoutes.register2 ||
          state.matchedLocation == AppRoutes.welcome ||
          state.matchedLocation == AppRoutes.forgotPassword;
      final isSplash = state.matchedLocation == AppRoutes.splash;

      // Show splash during initial check
      if (authState.status == AuthStatus.initial) {
        return isSplash ? null : AppRoutes.splash;
      }

      // If not authenticated and not on auth pages, redirect to login
      if (authState.status == AuthStatus.unauthenticated) {
        return isLoggingIn ? null : AppRoutes.welcome;
      }

      // If authenticated and on auth pages, redirect to appropriate home
      if (authState.status == AuthStatus.authenticated ||
          authState.status == AuthStatus.guest) {
        if (isLoggingIn || isSplash) {
          return AppRoutes.dashboard;
        }
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.register1,
        builder: (context, state) => const RegisterStep1Screen(),
      ),
      GoRoute(
        path: AppRoutes.register2,
        builder: (context, state) {
          final studentKey = state.pathParameters['studentKey']!;
          final schoolKey = state.pathParameters['schoolKey']!;
          return RegisterStep2Screen(
            studentKey: studentKey,
            schoolKey: schoolKey,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // User routes
      ShellRoute(
        builder: (context, state, child) => UserShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.myStudents,
            builder: (context, state) => MyStudentsScreen(),
          ),
          GoRoute(
            path: AppRoutes.studentAttendance,
            builder: (context, state) {
              final studentId = state.pathParameters['studentId']!;
              return StudentAttendanceScreen(studentId: studentId);
            },
          ),
          GoRoute(
            path: AppRoutes.addSubscription,
            builder: (context, state) => const AddSubscriptionScreen(),
          ),
          GoRoute(
            path: AppRoutes.announcements,
            builder: (context, state) => const AnnouncementsScreen(),
          ),
          GoRoute(
            path: AppRoutes.announcementsDetail,
            builder: (context, state) {
              final announcementId = state.pathParameters['announcementId']!;
              return AnnouncementDetailScreen(announcementId: announcementId);
            },
          ),
          GoRoute(
            path: AppRoutes.calendar,
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: AppRoutes.event,
            builder: (context, state) {
              final eventId = state.pathParameters['eventId']!;
              return EventDetailScreen(eventId: eventId);
            },
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
});

String _getHomeRouteForRole(UserRole? role) {
  switch (role) {
    case UserRole.customer:
      return AppRoutes.customerHome;
    case UserRole.driver:
      return AppRoutes.driverHome;
    case UserRole.owner:
      return AppRoutes.ownerDashboard;
    default:
      return AppRoutes.customerHome; // Default for guest
  }
}

// Shell widgets for bottom navigation
class UserShell extends StatefulWidget {
  final Widget child;
  UserShell({super.key, required this.child});

  @override
  State<UserShell> createState() => _UserShellState();
}

class _UserShellState extends State<UserShell> {
  int _selectedIndex = 0;

  // Define your icons here (Active solid color vs outline color)
  final List _icons = [
    'assets/icons/Home.svg',
    'assets/icons/Document.svg',
    'assets/icons/chart.svg',
    'assets/icons/message-text.svg',
    'assets/icons/user-2.svg',
  ];

  final List _iconsActive = [
    'assets/icons/Home-active.svg',
    'assets/icons/Document-active.svg',
    'assets/icons/chart-active.svg',
    'assets/icons/message-text-active.svg',
    'assets/icons/user-active.svg',
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint('[UserShell] build() called');
    return Scaffold(
      backgroundColor:
          Colors.white, // Background to showcase the white container
      body: Center(child: widget.child),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 72,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(
          //     30,
          //   ), // Gives it that modern pill shape
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.05),
          //       blurRadius: 10,
          //       offset: const Offset(0, -2),
          //     ),
          //   ],
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = _calculateSelectedIndex(context) == index;

              return InkWell(
                onTap: () {
                  _onItemTapped(index, context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top spacing to perfectly center the icon vertically
                    const SizedBox(height: 12),

                    // The Navigation Icon
                    SvgPicture.asset(
                      isSelected ? _iconsActive[index] : _icons[index],
                      width: 24,
                      height: 24,
                    ),

                    // The Bottom Indicator Bar shown in your screenshot
                    SizedBox(height: 5),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      height: 5,
                      width: isSelected
                          ? 40
                          : 0, // Expands from 0 to 40 when selected
                      decoration: const BoxDecoration(
                        color: Color(0xFF1A60FF), // Your signature blue
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppRoutes.dashboard)) return 0;
    if (location.startsWith(AppRoutes.calendar)) return 1;
    if (location.startsWith(AppRoutes.myStudents)) return 2;
    if (location.startsWith(AppRoutes.announcements)) return 3;
    if (location.startsWith(AppRoutes.settings)) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.dashboard);
        break;
      case 1:
        context.go(AppRoutes.calendar);
        break;
      case 2:
        context.go(AppRoutes.myStudents);
      case 3:
        context.go(AppRoutes.announcements);
      case 4:
        context.go(AppRoutes.settings);
        break;
    }
  }
}

// Error screen
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Something went wrong',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
