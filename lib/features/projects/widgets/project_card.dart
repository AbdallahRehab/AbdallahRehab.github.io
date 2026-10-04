import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section.dart';

/// One case study in the work grid: domain, name at display size with its
/// user scale, the context, its headline outcome and stack, and an arrow
/// that turns to point ahead on hover.
class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final VoidCallback onTap;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final name = project['name'] as String? ?? 'Project';
    final domain = project['domain'] as String?;
    final scale = project['scaleLabel'] as String?;
    final platforms = (project['platforms'] as List<dynamic>? ?? [])
        .cast<String>();
    final impact = (project['impact'] as List<dynamic>? ?? []).cast<String>();
    final tech = (project['technologies'] as List<dynamic>? ?? [])
        .cast<String>();

    return Reveal(
      delay: Duration(milliseconds: 70 * (index % 2)),
      child: Pressable(
        onTap: onTap,
        focusRadius: Space.radius,
        semanticLabel: 'Open case study: $name',
        builder: (context, active) => AnimatedContainer(
          duration: Space.slow,
          curve: Space.easeOut,
          padding: EdgeInsets.all(AppType.fluid(context, 20, 32)),
          decoration: BoxDecoration(
            color: active ? p.surfaceHover : p.surface,
            borderRadius: BorderRadius.circular(Space.radius),
            border: Border.all(color: active ? p.line : p.lineFaint),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppType.h3(
                            context,
                            size: AppType.fluid(context, 30, 40),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          [?domain, ?scale].join('  ·  '),
                          style: AppType.caption(
                            context,
                          ).copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  for (final platform in platforms) ...[
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(
                        platform == 'ios'
                            ? FontAwesomeIcons.apple.data
                            : FontAwesomeIcons.android.data,
                        size: 15,
                        color: p.inkFaint,
                        semanticLabel: platform == 'ios' ? 'iOS' : 'Android',
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Text(
                project['context'] as String? ?? '',
                style: AppType.body(context, size: 15.5),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              if (impact.isNotEmpty) ...[
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: p.signal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        impact.first,
                        style: AppType.ui(context, size: 15),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 18),
              TagList(tech.take(4).toList()),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Read case study',
                    style: AppType.ui(
                      context,
                      size: 14,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 12),
                  ArrowCircle(size: 32, active: active),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
