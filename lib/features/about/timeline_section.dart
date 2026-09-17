import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  static const _entries = [
    _TimelineEntry(
      period: 'Nov 2025 — Present',
      role: 'Senior Mobile Engineer',
      company: 'MEGAMIND IT Solutions · Cairo',
      summary:
          'Leading Flutter development for a large-scale healthcare mobile '
          'application serving a high volume of active users across Android & iOS.',
      bullets: [
        'Architected, refactored, and modularized a legacy codebase to cut technical debt and improve maintainability.',
        'Implemented CI/CD pipelines and automated testing standards, accelerating release cycles.',
        'Improved overall application performance by ~40% — faster startup, smoother navigation, optimized runtime.',
        'Applied healthcare-grade security: secure data storage, encrypted communication, hardened authentication.',
      ],
      metrics: ['~40% faster', 'Healthcare-grade security'],
    ),
    _TimelineEntry(
      period: 'Dec 2022 — Oct 2025',
      role: 'Senior Mobile Developer',
      company: 'WalaPlus · Riyadh, KSA',
      summary:
          'Built and scaled WalaOne, WalaPlus, and Doam — loyalty & rewards '
          'products reaching 3M+ active users with 4.5+ app store ratings.',
      bullets: [
        'Initiated and led Doam from scratch — architecture, CI/CD pipelines, and coding standards — serving 1.2M+ users.',
        'Enhanced performance via caching, API optimization, and refactoring, achieving up to 60% faster load times.',
        'Implemented unit testing with Mocktail, reaching up to 90% code coverage and cutting bug reports by 70%.',
        'Introduced modular architecture and a threat model hardening apps against reverse engineering and MiTM attacks.',
      ],
      metrics: ['3M+ users', '60% faster', '90% test coverage'],
    ),
    _TimelineEntry(
      period: 'Dec 2020 — Dec 2022',
      role: 'Flutter Developer',
      company: 'WEDDnGO · Nasr City, Cairo',
      summary:
          'Contributed to Egypt\'s largest wedding marketplace app, connecting '
          'users with service providers.',
      bullets: [
        'Helped secure funding through Shark Tank Egypt by delivering high-quality features and performance work.',
        'Integrated vendor subscriptions, booking systems, and in-app payments.',
        'Optimized app performance, improving load times and responsiveness.',
      ],
      metrics: ['Shark Tank Egypt'],
    ),
    _TimelineEntry(
      period: '2016 — 2020',
      role: 'B.Sc. Computer Science',
      company: 'Menoufiya University',
      summary: 'Faculty of Computers and Information · GPA 3.2',
      bullets: [],
      metrics: [],
      isEducation: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Text(
            'Experience',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textColor(context),
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 12),
          Text(
            'Six-plus years shipping production Flutter apps for millions of users.',
            style: TextStyle(color: AppTheme.textColorSecondary(context)),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              children: [
                for (int i = 0; i < _entries.length; i++)
                  _TimelineItem(
                    entry: _entries[i],
                    isLast: i == _entries.length - 1,
                    delay: Duration(milliseconds: i * 120),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry {
  final String period;
  final String role;
  final String company;
  final String summary;
  final List<String> bullets;
  final List<String> metrics;
  final bool isEducation;

  const _TimelineEntry({
    required this.period,
    required this.role,
    required this.company,
    required this.summary,
    required this.bullets,
    required this.metrics,
    this.isEducation = false,
  });
}

class _TimelineItem extends StatelessWidget {
  final _TimelineEntry entry;
  final bool isLast;
  final Duration delay;

  const _TimelineItem({
    required this.entry,
    required this.isLast,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: entry.isEducation
                      ? textSecondary.withValues(alpha: 0.4)
                      : accent,
                  shape: BoxShape.circle,
                  boxShadow: entry.isEducation
                      ? null
                      : [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppTheme.borderColor(context),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.period,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.role,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.company,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: textSecondary),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    entry.summary,
                    style: TextStyle(color: textSecondary, height: 1.6),
                  ),
                  if (entry.bullets.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ...entry.bullets.map(
                      (b) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: textSecondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                b,
                                style: TextStyle(
                                  color: textSecondary,
                                  height: 1.5,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (entry.metrics.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: entry.metrics
                          .map(
                            (m) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.chipBackground(context),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.chipBorder(context),
                                ),
                              ),
                              child: Text(
                                m,
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
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay).slideX(delay: delay, begin: 0.05, end: 0);
  }
}
