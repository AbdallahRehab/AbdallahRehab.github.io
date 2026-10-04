import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section.dart';
import '../project_taxonomy.dart';
import 'engineering_story_strip.dart';

/// Full case study for one project, read straight from assets/config.json.
class ProjectDetailsModal extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final links = project['links'] as Map<String, dynamic>? ?? {};
    final platforms = (project['platforms'] as List<dynamic>? ?? [])
        .cast<String>();
    final scaleLabel = project['scaleLabel'] as String?;
    final domain = project['domain'] as String?;
    final storyStages = (project['storyStages'] as List<dynamic>?)
        ?.cast<String>();
    final impact = (project['impact'] as List<dynamic>? ?? []).cast<String>();
    final tech = (project['technologies'] as List<dynamic>? ?? [])
        .cast<String>();
    final pad = AppType.fluid(context, 20, 40);
    final size = MediaQuery.sizeOf(context);

    final facts = <(String, String)>[
      if (scaleLabel != null) ('Users', scaleLabel),
      if (domain != null) ('Domain', domain),
      if (platforms.isNotEmpty)
        (
          'Platforms',
          platforms.map((e) => e == 'ios' ? 'iOS' : 'Android').join(' · '),
        ),
    ];

    final blocks = <(String, String)>[
      if ((project['context'] as String?)?.isNotEmpty ?? false)
        ('Overview', project['context'] as String),
      if ((project['challenge'] as String?)?.isNotEmpty ?? false)
        ('Challenge', project['challenge'] as String),
      if ((project['contribution'] as String?)?.isNotEmpty ?? false)
        ('My contribution', project['contribution'] as String),
    ];

    return Dialog(
      backgroundColor: p.ground,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: Space.gutter(context),
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Space.radius),
        side: BorderSide(color: p.line),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: size.height * 0.88,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(pad),
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
                        Semantics(
                          header: true,
                          headingLevel: 2,
                          child: Text(
                            project['name'] as String? ?? '',
                            style: AppType.h3(
                              context,
                              size: AppType.fluid(context, 34, 52),
                            ).copyWith(height: 1),
                          ),
                        ),
                        if ((project['tagline'] as String?)?.isNotEmpty ??
                            false) ...[
                          const SizedBox(height: 8),
                          Text(
                            project['tagline'] as String,
                            style: AppType.lead(context),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleIconButton(
                    icon: Icons.close_rounded,
                    semanticLabel: 'Close',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              if (facts.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: p.line),
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var i = 0; i < facts.length; i++) ...[
                          if (i > 0)
                            VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: p.line,
                            ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                i == 0 ? 0 : 14,
                                14,
                                8,
                                14,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    facts[i].$1,
                                    style: AppType.caption(context),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    facts[i].$2,
                                    style: AppType.ui(context, size: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              if (storyStages != null && storyStages.isNotEmpty) ...[
                const SizedBox(height: 24),
                EngineeringStoryStrip(stages: storyStages),
              ],
              const SizedBox(height: 12),
              for (final (label, body) in blocks)
                _Block(
                  label: label,
                  child: Text(body, style: _bodyStyle(context)),
                ),
              if (impact.isNotEmpty)
                _Block(
                  label: 'Impact',
                  child: DashList(impact, style: _bodyStyle(context)),
                ),
              if (tech.isNotEmpty)
                _Block(
                  label: 'Engineering',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final entry in ProjectTaxonomy.groupTechnologies(
                        tech,
                      ).entries)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: AppType.caption(
                                  context,
                                ).copyWith(color: p.ink),
                              ),
                              const SizedBox(height: 6),
                              TagList(entry.value),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              if (links['ios'] != null || links['android'] != null) ...[
                const SizedBox(height: 24),
                Wrap(
                  spacing: Space.gap,
                  runSpacing: Space.gap,
                  children: [
                    if (links['ios'] != null)
                      PillButton(
                        label: 'App Store',
                        icon: FontAwesomeIcons.apple.data,
                        onPressed: () => Pressable.open(links['ios']),
                      ),
                    if (links['android'] != null)
                      PillButton(
                        label: 'Google Play',
                        icon: FontAwesomeIcons.googlePlay.data,
                        variant: PillVariant.outline,
                        onPressed: () => Pressable.open(links['android']),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _bodyStyle(BuildContext context) => AppType.body(
    context,
    size: 16,
  ).copyWith(color: context.palette.ink.withValues(alpha: 0.88));
}

/// Label column + body column on wide dialogs, stacked on narrow ones,
/// separated by hairlines.
class _Block extends StatelessWidget {
  final String label;
  final Widget child;

  const _Block({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final heading = Text(label.toUpperCase(), style: AppType.label(context));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: p.lineFaint)),
      ),
      child: LayoutBuilder(
        builder: (context, c) => c.maxWidth > 560
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: heading,
                    ),
                  ),
                  Expanded(child: child),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [heading, const SizedBox(height: 10), child],
              ),
      ),
    );
  }
}
