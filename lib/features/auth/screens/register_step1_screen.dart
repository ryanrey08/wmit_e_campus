import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

import './register_step2_screen.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  State<RegisterStep1Screen> createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  final _formKey = GlobalKey<FormState>();

  final _studentKeyController = TextEditingController();
  final _schoolKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _schoolKeyController.addListener(_onChanged);
    _studentKeyController.addListener(_onChanged);
  }

  void _onChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _schoolKeyController.removeListener(_onChanged);
    _studentKeyController.removeListener(_onChanged);

    _schoolKeyController.dispose();
    _studentKeyController.dispose();

    super.dispose();
  }

  bool isDisabled() {
    return _studentKeyController.text.trim().isEmpty &&
        _schoolKeyController.text.trim().isEmpty;
  }

  void _goNext() {
    if (_formKey.currentState!.validate()) {
      context.push(
        '/register2',
        extra: {
          'studentKey': _studentKeyController.text.trim(),
          'schoolKey': _schoolKeyController.text.trim(),
        },
      );
    }
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
                          height: 1.25,
                          fontFamily: AppTheme.themePoppins,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Enter school key or student key',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppTheme.themePoppins,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 48),

                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'School Key',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppTheme.themePoppins,
                                fontWeight: FontWeight.w400,
                                color: AppColors.loginLabel,
                                height: 1.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _studentKeyController,
                        hint: 'Enter school key',
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/icons/book-open-02.svg',
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Student Key',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppTheme.themePoppins,
                                fontWeight: FontWeight.w400,
                                color: AppColors.loginLabel,
                                height: 1.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _schoolKeyController,
                        hint: 'Enter student key',
                        prefixWidget: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/icons/student-card.svg',
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: CustomButton(
                          text: 'Next',
                          onPressed: isDisabled() ? null : _goNext,
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
