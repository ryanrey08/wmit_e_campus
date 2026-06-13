import 'package:flutter/material.dart';
import '/core/theme/app_theme.dart' show AppColors;
import '/features/auth/screens/register_screen.dart';
import '../terms_and_privacy/privacy.dart';
import '../terms_and_privacy/terms.dart';

class LegalModal extends StatelessWidget {
  final LegalType type;

  const LegalModal({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final title = type == LegalType.terms
        ? 'Terms & Conditions'
        : 'Privacy Policy';

    final content = type == LegalType.terms ? termsContent : privacyContent;

    return Container(
      height: MediaQuery.of(context).size.height * .92,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: SelectableText(
                content,
                style: const TextStyle(height: 1.7, fontSize: 15),
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
