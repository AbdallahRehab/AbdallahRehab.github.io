import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// A horizontal step track for projects with a real before/after
/// engineering narrative (e.g. greenfield → scaled). Only rendered when the
/// project config supplies `storyStages` — projects without one don't get a
/// fabricated arc. The final stage, where it landed, is filled.
class EngineeringStoryStrip extends StatelessWidget {
  final List<String> stages;

  const EngineeringStoryStrip({super.key, required this.stages});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      label: 'Engineering story: ${stages.join(', then ')}',
      excludeSemantics: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < stages.length; i++) ...[
              if (i > 0) Container(width: 16, height: 1, color: p.line),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: i == stages.length - 1 ? p.accent : null,
                  borderRadius: BorderRadius.circular(Space.pill),
                  border: Border.all(
                    color: i == stages.length - 1 ? p.accent : p.line,
                  ),
                ),
                child: Text(
                  stages[i],
                  style: AppType.caption(context).copyWith(
                    fontSize: 12.5,
                    color: i == stages.length - 1 ? p.onAccent : p.inkMuted,
                    fontWeight: i == stages.length - 1 ? FontWeight.w600 : null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
