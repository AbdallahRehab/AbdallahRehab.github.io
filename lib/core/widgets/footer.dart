import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.borderColor(context))),
      ),
      child: Column(
        children: [
          Text(
            '© ${DateTime.now().year} Abdallah Ali Rehab. All rights reserved.',
            style: TextStyle(
              color: AppTheme.textColorSecondary(context),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter Web',
            style: TextStyle(
              color: AppTheme.primaryColor(context).withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
