import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_button.dart';
import '../project_taxonomy.dart';
import 'engineering_story_strip.dart';

class ProjectDetailsModal extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);
    final links = project['links'] as Map<String, dynamic>? ?? {};
    final platforms = (project['platforms'] as List<dynamic>? ?? [])
        .cast<String>();
    final scaleLabel = project['scaleLabel'] as String?;
    final domain = project['domain'] as String?;
    final storyStages = (project['storyStages'] as List<dynamic>?)
        ?.cast<String>();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 720,
        constraints: const BoxConstraints(maxHeight: 720),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor(context),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: accent.withValues(alpha: 0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.1),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['name'] ?? '',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if ((project['tagline'] as String?)?.isNotEmpty ??
                              false) ...[
                            const SizedBox(height: 4),
                            Text(
                              project['tagline'],
                              style: TextStyle(
                                color: accent,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Semantics(
                      button: true,
                      label: 'Close',
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: textColor),
                        tooltip: 'Close',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Scale strip — domain, user scale, and platforms at a glance.
                if (domain != null || scaleLabel != null || platforms.isNotEmpty)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      if (domain != null) _Pill(text: domain, accent: accent),
                      if (scaleLabel != null)
                        _Pill(text: scaleLabel, accent: accent, filled: true),
                      for (final platform in platforms)
                        _Pill(
                          text: platform == 'ios' ? 'iOS' : 'Android',
                          accent: accent,
                          icon: platform == 'ios'
                              ? Icons.apple
                              : Icons.android,
                        ),
                    ],
                  ),

                if (storyStages != null && storyStages.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  EngineeringStoryStrip(stages: storyStages),
                ],

                const SizedBox(height: 28),
                if ((project['context'] as String?)?.isNotEmpty ?? false)
                  _Block(
                    label: 'Overview',
                    body: project['context'],
                    textColor: textColor,
                    textSecondary: textSecondary,
                  ),
                if ((project['challenge'] as String?)?.isNotEmpty ?? false)
                  _Block(
                    label: 'Challenge',
                    body: project['challenge'],
                    textColor: textColor,
                    textSecondary: textSecondary,
                  ),
                if ((project['contribution'] as String?)?.isNotEmpty ?? false)
                  _Block(
                    label: 'My Contribution',
                    body: project['contribution'],
                    textColor: textColor,
                    textSecondary: textSecondary,
                  ),
                if ((project['impact'] as List<dynamic>?)?.isNotEmpty ??
                    false) ...[
                  Text(
                    'IMPACT',
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['impact'] as List<dynamic>)
                        .map(
                          (m) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.chipBackground(context),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.chipBorder(context),
                              ),
                            ),
                            child: Text(
                              m.toString(),
                              style: TextStyle(
                                color: accent,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                if ((project['technologies'] as List<dynamic>?)?.isNotEmpty ??
                    false) ...[
                  Text(
                    'ENGINEERING',
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...ProjectTaxonomy.groupTechnologies(
                    (project['technologies'] as List<dynamic>)
                        .cast<String>(),
                  ).entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                color: accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          for (final tech in entry.value)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.borderColor(
                                  context,
                                ).withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (links['ios'] != null || links['android'] != null)
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      if (links['ios'] != null)
                        GlassButton(
                          text: 'App Store',
                          icon: Icons.apple,
                          onPressed: () => launchUrl(
                            Uri.parse(links['ios']),
                            mode: LaunchMode.externalApplication,
                          ),
                        ),
                      if (links['android'] != null)
                        GlassButton(
                          text: 'Play Store',
                          icon: Icons.android,
                          isPrimary: false,
                          onPressed: () => launchUrl(
                            Uri.parse(links['android']),
                            mode: LaunchMode.externalApplication,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color accent;
  final bool filled;
  final IconData? icon;

  const _Pill({
    required this.text,
    required this.accent,
    this.filled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? accent.withValues(alpha: 0.14) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: accent),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  final String label;
  final String body;
  final Color textColor;
  final Color textSecondary;

  const _Block({
    required this.label,
    required this.body,
    required this.textColor,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.85),
              height: 1.6,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
