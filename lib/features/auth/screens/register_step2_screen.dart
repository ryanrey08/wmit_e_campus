import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class RegisterStep2Screen extends StatefulWidget {
  final String studentKey;
  final String schoolKey;

  const RegisterStep2Screen({
    super.key,
    required this.studentKey,
    required this.schoolKey,
  });

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  bool isDisabled() {
    return _fullNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty;
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      Navigator.pushReplacementNamed(context, '/dashboard');
    });
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
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppTheme.themePoppins,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppTheme.themePoppins,
                        ),
                      ),

                      const SizedBox(height: 48),

                      const Text('Full Name'),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _fullNameController,
                        hint: 'Enter full name',
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset('assets/icons/user.svg'),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text('Email'),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _emailController,
                        hint: 'Enter email',
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/icons/mail-at-sign-02.svg',
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text('Password'),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _passwordController,
                        hint: 'Enter password',
                        obscureText: true,
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/icons/lock-password.svg',
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: CustomButton(
                          text: 'Register',
                          isLoading: _isLoading,
                          onPressed: isDisabled() ? null : _register,
                          disabled: isDisabled(),
                          backgroundColor: AppColors.button,
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
