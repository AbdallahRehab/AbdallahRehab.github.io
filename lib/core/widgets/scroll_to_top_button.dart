import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pressable.dart';

/// Quiet hairline circle that appears once the page has scrolled — kept
/// out of lime so it never competes with the real calls to action.
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
    final p = context.palette;
    return IgnorePointer(
      ignoring: !isVisible,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Space.fast,
        child: AnimatedSlide(
          offset: isVisible ? Offset.zero : const Offset(0, 0.4),
          duration: Space.slow,
          curve: Space.expo,
          child: ExcludeFocus(
            excluding: !isVisible,
            child: Tooltip(
              message: 'Back to top',
              child: Pressable(
                onTap: onPressed,
                semanticLabel: 'Back to top',
                builder: (context, active) => AnimatedContainer(
                  duration: Space.fast,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.ground.withValues(alpha: 0.92),
                    border: Border.all(color: active ? p.accentInk : p.line),
                  ),
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 20,
                    color: active ? p.accentInk : p.ink,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
