import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart'
    show AppColors, AppTheme, AppGradients;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Local list of image assets for the slider
  final List<String> _sliderImages = [
    'assets/images/casual-life-3d-reading.webp', // The original "welcomepage.png" image
    'assets/images/casual-life-3d-likes.webp',
    'assets/images/casual-life-3d-meditation-crystal.webp',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.onboardingBackground,
        ),
        child: Stack(
          children: [
            // Upper Section: Swipeable Slider and Dot Indicators
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Swipeable Image Slider
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemCount: _sliderImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Image.asset(
                            _sliderImages[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),

                  // Page View Indicators (Dots synced with State)
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _sliderImages.length,
                        (index) => _buildDot(isActive: index == _currentPage),
                      ),
                    ),
                  ),

                  // Fixed spacer match to keep content from getting squished
                  SizedBox(height: screenSize.height * 0.42),
                ],
              ),
            ),

            // Lower Section: Persistent Blue Content Card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenSize.height * 0.42,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.onboardingCard,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text Headlines
                      Column(
                        children: const [
                          SizedBox(height: 16),
                          Text(
                            'WMIT E–CAMPUS',
                            style: TextStyle(
                              color: AppColors.onboardingTitle,
                              fontSize: 28,
                              height: 1.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.0,
                              fontFamily: AppTheme.themePoppins,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 18),
                          Text(
                            'Time and Attendance Notification',
                            style: TextStyle(
                              color: AppColors.onboardingTitle,
                              fontFamily: AppTheme.themePoppins,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      // "Get Started" Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle next onboarding step or navigation
                            context.push('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.onboardingPrimaryButton,
                            foregroundColor:
                                AppColors.onboardingPrimaryButtonText,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppTheme.themeRoboto,
                              height: 1.0,
                              letterSpacing: 0.0,
                              color: AppColors.onboardingPrimaryButtonText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Active/Inactive animated tracking dot builder
  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8,
      width: 8, // Subtly expands active dot for polish
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.onboardingActiveDot
            : AppColors.onboardingInactiveDot,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
