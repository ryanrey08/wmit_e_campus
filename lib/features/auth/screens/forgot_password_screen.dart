import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  bool _isLoading = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  bool _isEmail(String value) {
    return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(value);
  }

  bool _isPhone(String value) {
    return RegExp(r'^[0-9]{10,15}$').hasMatch(value.replaceAll(' ', ''));
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO:
      // await authProvider.forgotPassword(
      //   identifier: _identifierController.text.trim(),
      // );

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isSubmitted = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Unable to process your request. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildErrorBanner() {
    if (_errorMessage == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationState() {
    return Column(
      children: [
        const SizedBox(height: 40),

        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 40,
            color: AppColors.success,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Check Your Email or SMS',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        const Text(
          'If an account exists for the email address or phone number provided, password reset instructions have been sent.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary),
        ),

        const SizedBox(height: 32),

        CustomButton(
          text: 'Back to Login',
          onPressed: () {
            context.go('/login');
          },
        ),
      ],
    );
  }

  Widget _buildFormState() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Text(
          //   'Forgot Password?',
          //   style: Theme.of(
          //     context,
          //   ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 12),

          const Text(
            'Enter your email address or phone number and we will send password reset instructions.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),

          const SizedBox(height: 32),

          CustomTextField(
            controller: _identifierController,
            label: 'Email or Phone Number',
            hint: 'john.doe@email.com or 09123456789',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email or phone number';
              }

              final input = value.trim();

              if (!_isEmail(input) && !_isPhone(input)) {
                return 'Enter a valid email or phone number';
              }

              return null;
            },
          ),

          const SizedBox(height: 24),

          CustomButton(
            width: double.infinity,
            text: 'Send Reset Instructions',
            isLoading: _isLoading,
            onPressed: _handleSubmit,
          ),

          const SizedBox(height: 16),

          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Back to Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildErrorBanner(),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _isSubmitted
                    ? _buildConfirmationState()
                    : _buildFormState(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
