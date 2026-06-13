import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/models/student_match_model.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _codeController = TextEditingController();

  bool _isValidating = false;
  bool _isSubscribing = false;

  String? _errorMessage;
  String? _bannerMessage;

  StudentMatch? _studentMatch;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _validateCode() async {
    FocusScope.of(context).unfocus();

    final code = _codeController.text.trim().toUpperCase();

    if (code.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your subscription code';
      });
      return;
    }

    setState(() {
      _isValidating = true;
      _errorMessage = null;
      _bannerMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      // TODO:
      // final result = await subscriptionService.previewCode(code);

      if (code == 'ABC12345') {
        setState(() {
          _studentMatch = StudentMatch(
            studentId: '1',
            studentName: 'Juan Dela Cruz',
            className: 'Section A',
            gradeLevel: 'Grade 6',
            schoolName: 'Acme School',
          );
        });
      } else {
        setState(() {
          _errorMessage = 'Code not recognized — check with your school';
        });
      }
    } catch (_) {
      setState(() {
        _bannerMessage = 'Network error. Please try again.';
      });
    } finally {
      setState(() {
        _isValidating = false;
      });
    }
  }

  Future<void> _subscribe() async {
    if (_studentMatch == null) return;

    setState(() {
      _isSubscribing = true;
    });

    try {
      // TODO:
      //
      // final fcmToken =
      //     await FirebaseMessaging.instance.getToken();
      //
      // await subscriptionService.subscribe(
      //   studentId: _studentMatch!.studentId,
      //   fcmToken: fcmToken,
      // );

      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subscribed to ${_studentMatch!.studentName}')),
      );

      context.go('/student/${_studentMatch!.studentId}');
    } finally {
      setState(() {
        _isSubscribing = false;
      });
    }
  }

  void _showCodeHelp() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Where is my code?'),
          content: const Text(
            'Your school provides a printed subscription code. Contact the school administration if you have not received one.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCodeInput() {
    return Column(
      children: [
        const SizedBox(height: 16),

        Text(
          'Enter Subscription Code',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        const Text(
          'Enter the code provided by your school.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        TextField(
          controller: _codeController,
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.characters,
          maxLength: 12,
          style: const TextStyle(
            fontSize: 24,
            letterSpacing: 6,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'ABC12345',
            counterText: '',
            errorText: _errorMessage,
          ),
          onChanged: (value) {
            final formatted = value.trim().toUpperCase();

            if (formatted != value) {
              _codeController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          },
        ),

        const SizedBox(height: 12),

        TextButton(
          onPressed: _showCodeHelp,
          child: const Text('Where is my code?'),
        ),

        const SizedBox(height: 32),

        CustomButton(
          width: double.infinity,
          text: 'Continue',
          isLoading: _isValidating,
          onPressed: _validateCode,
        ),
      ],
    );
  }

  Widget _buildPreviewCard() {
    final student = _studentMatch!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.verified_user_outlined,
              size: 48,
              color: AppColors.success,
            ),

            const SizedBox(height: 16),

            Text(
              student.studentName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(student.gradeLevel),

            Text(student.className),

            const SizedBox(height: 4),

            Text(
              student.schoolName,
              style: const TextStyle(color: AppColors.textSecondary),
            ),

            const SizedBox(height: 32),

            CustomButton(
              text: 'Subscribe',
              isLoading: _isSubscribing,
              onPressed: _subscribe,
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () {
                setState(() {
                  _studentMatch = null;
                });
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    if (_bannerMessage == null) {
      return const SizedBox.shrink();
    }

    return Container(
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
          Expanded(child: Text(_bannerMessage!)),
          TextButton(onPressed: _validateCode, child: const Text('Retry')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Keeps the top clean and flat
        elevation: 0, // Removes the default drop shadow
        // 1. Customize the Back Button
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Standard material back arrow
            color: Color(
              0xFF1E2229,
            ), // Deep dark slate grey matching your screenshot
            size: 28,
          ),
          onPressed: () {
            Navigator.maybePop(
              context,
            ); // Safely pops back to the previous screen
          },
        ),

        // 2. Reduce spacing between the back arrow and title
        titleSpacing: 0,

        // 3. Style the Title
        title: const Text(
          'Add a Student',
          style: TextStyle(
            fontFamily: AppTheme.themePoppins,
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Color(0xFF21242D),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildBanner(),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _studentMatch == null
                    ? _buildCodeInput()
                    : _buildPreviewCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
