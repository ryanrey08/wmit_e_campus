import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmit_e_campus/core/constants/app_constants.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberPassword = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_onChanged);
    _passwordController.addListener(_onChanged);
  }

  void _onChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.removeListener(_onChanged);
    _passwordController.removeListener(_onChanged);

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _handleLogin() async {
    final SharedPreferences p = await SharedPreferences.getInstance();
    p.setString(AppConstants.tokenKey, "dnsjdsjdjsdfbfsdf");
    p.setString(AppConstants.userKey, '{"name":"Juan Dela Cruz"}');
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (mounted) {
      context.go('/dashboard');
    }
  }

  bool isDisabled() {
    return _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        foregroundColor: AppColors.black,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IconButton(
                      //   padding: EdgeInsets.zero,
                      //   constraints: const BoxConstraints(),
                      //   onPressed: () => context.pop(),
                      //   icon: const Icon(Icons.arrow_back, size: 22),
                      // ),
                      // const SizedBox(height: 32),
                      const Text(
                        'Welcome\nBack!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                          color: AppColors.loginTitle,
                          letterSpacing: 36 * 0.02, // 0.72
                          fontFamily: AppTheme.themePoppins,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontFamily: AppTheme.themePoppins,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          letterSpacing: 0.0,
                        ),
                      ),

                      const SizedBox(height: 48),

                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Full Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppTheme.themePoppins,
                                fontWeight: FontWeight.w400,
                                color: AppColors.loginLabel,
                                height: 1.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: AppColors.required,
                                fontFamily: AppTheme.themePoppins,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _emailController,
                        hint: 'Enter full name',
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppTheme.themePoppins,
                                fontWeight: FontWeight.w400,
                                color: AppColors.loginLabel,
                                height: 1.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: AppColors.required,
                                fontFamily: AppTheme.themePoppins,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _passwordController,
                        hint: 'Enter password',
                        obscureText: true,
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/icons/lock-password.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          SizedBox(
                            height: 22,
                            width: 22,
                            child: Checkbox(
                              value: _rememberPassword,
                              onChanged: (value) {
                                setState(() {
                                  _rememberPassword = value ?? false;
                                });
                              },
                              side: BorderSide(
                                color: AppColors.checkBox,
                                width: 1.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Remember Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppTheme.themePoppins,
                              fontWeight: FontWeight.w300,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 36),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: CustomButton(
                          text: 'Sign In',
                          isLoading: _isLoading,
                          onPressed: isDisabled() ? null : _handleLogin,
                          backgroundColor: AppColors.button,
                          disabled: isDisabled(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Don't have an Account yet?",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w300,
                                height: 16 / 20,
                                letterSpacing: 0.8,
                                fontFamily: AppTheme.themePoppins,
                              ),
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: () {
                                context.push('/register1');
                              },
                              child: const Text(
                                'Register now!',
                                style: TextStyle(
                                  color: AppColors.button,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppTheme.themePoppins,
                                  height: 1.0,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: AppTheme.themePoppins,
                      fontWeight: FontWeight.w300,
                      height: 16 / 20,
                      letterSpacing: 0.8,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(text: 'Copyright © '),
                      TextSpan(
                        text: 'WeMake IT Solutions, Inc.',
                        style: TextStyle(
                          color: AppColors.button,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: '  All Rights Reserved.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
