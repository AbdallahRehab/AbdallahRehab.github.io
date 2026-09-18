import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// A small horizontal "stage strip" for projects with a real before/after
/// engineering narrative (e.g. legacy → modernized, or greenfield → scaled).
/// Only rendered when the project config supplies `storyStages` — projects
/// without one don't get a fabricated arc.
class EngineeringStoryStrip extends StatelessWidget {
  final List<String> stages;

  const EngineeringStoryStrip({super.key, required this.stages});

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < stages.length; i++) ...[
            if (i > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: textSecondary.withValues(alpha: 0.5),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.chipBackground(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.chipBorder(context)),
              ),
              child: Text(
                stages[i],
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
