import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class ScrollToTopButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;

  const ScrollToTopButton({
    super.key,
    required this.onPressed,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: isVisible
          ? FloatingActionButton(
                  onPressed: onPressed,
                  backgroundColor: AppTheme.primaryColor(context),
                  tooltip: 'Scroll to top',
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1))
          : const SizedBox.shrink(),
    );
  }
}
