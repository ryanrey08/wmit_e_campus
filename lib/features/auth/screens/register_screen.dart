import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/features/auth/screens/legal_modal.dart';

import '../../../core/theme/app_theme.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

enum LegalType { terms, privacy }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _emailFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _countryCodeController = TextEditingController(text: '+63');
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  bool _otpSent = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;

  String? _serverError;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _countryCodeController.dispose();
    _phoneController.dispose();
    _otpController.dispose();

    super.dispose();
  }

  Future<void> _handleEmailRegister() async {
    if (!_emailFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _serverError = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      context.go('/dashboard');
    } catch (e) {
      setState(() {
        _serverError = 'Unable to create your account. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendOtp() async {
    if (_phoneController.text.trim().isEmpty) return;

    setState(() {
      _otpSent = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP sent successfully')));
  }

  Future<void> _verifyOtpAndRegister() async {
    if (!_phoneFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _serverError = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      context.go('/dashboard');
    } catch (e) {
      setState(() {
        _serverError = 'Verification failed.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildServerErrorBanner() {
    if (_serverError == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _serverError!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _serverError = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTab() {
    return Form(
      key: _emailFormKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'john.doe@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }

              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              if (value.length < 8) {
                return 'Minimum 8 characters';
              }

              if (!RegExp(r'\d').hasMatch(value)) {
                return 'Must contain at least 1 number';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hint: 'Re-enter password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }

              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password must contain at least 8 characters and at least 1 number.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),

          const SizedBox(height: 24),

          CustomButton(
            width: double.infinity,
            text: 'Create Account',
            isLoading: _isLoading,
            onPressed: _handleEmailRegister,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneTab() {
    return Form(
      key: _phoneFormKey,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: CustomTextField(
                  controller: _countryCodeController,
                  label: 'Code',
                  hint: '+63',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: '9123456789',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (!_otpSent)
            CustomButton(
              width: double.infinity,
              text: 'Send OTP',
              onPressed: _sendOtp,
            ),

          if (_otpSent) ...[
            CustomTextField(
              controller: _otpController,
              label: 'OTP Code',
              hint: '123456',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.security_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter OTP';
                }

                if (value.length != 6) {
                  return 'OTP must be 6 digits';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _sendOtp,
                child: const Text('Resend Code'),
              ),
            ),

            const SizedBox(height: 16),

            CustomButton(
              width: double.infinity,
              text: 'Verify & Create Account',
              isLoading: _isLoading,
              onPressed: _verifyOtpAndRegister,
            ),
          ],
        ],
      ),
    );
  }

  void _showLegalModal(LegalType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return LegalModal(type: type);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final authState = AuthProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildServerErrorBanner(),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Email'),
                    Tab(text: 'Phone'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 500,
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildEmailTab(), _buildPhoneTab()],
                ),
              ),

              const SizedBox(height: 24),

              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'By continuing, you agree to our ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showLegalModal(LegalType.terms);
                    },
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(' and ', style: Theme.of(context).textTheme.bodySmall),
                  GestureDetector(
                    onTap: () {
                      _showLegalModal(LegalType.privacy);
                    },
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  context.push('/login');
                },
                child: const Text('Already have an account?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
