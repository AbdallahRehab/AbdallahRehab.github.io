import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/motion.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/section.dart';

/// Experience as a ledger on a rail: dates and place in a narrow left
/// column, a continuous hairline rail with a node per role, and the role's
/// story in the body column.
class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  static const _entries = [
    _TimelineEntry(
      period: 'Nov 2025 — Present',
      place: 'Cairo, Egypt',
      role: 'Senior Mobile Engineer',
      company: 'MEGAMIND IT Solutions',
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
      isCurrent: true,
    ),
    _TimelineEntry(
      period: 'Dec 2022 — Oct 2025',
      place: 'Riyadh, KSA',
      role: 'Senior Mobile Developer',
      company: 'WalaPlus',
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
      place: 'Nasr City, Cairo',
      role: 'Flutter Developer',
      company: 'WEDDnGO',
      summary:
          "Contributed to Egypt's largest wedding marketplace app, connecting "
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
      place: 'Menoufiya, Egypt',
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
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: "Where I've shipped",
            lead:
                'Six-plus years of production Flutter, from a marketplace '
                'startup to healthcare at scale.',
          ),
          LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth > 760;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < _entries.length; i++)
                    Reveal(
                      delay: Duration(milliseconds: 60 * i),
                      child: _TimelineItem(
                        entry: _entries[i],
                        wide: wide,
                        isFirst: i == 0,
                        isLast: i == _entries.length - 1,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry {
  final String period;
  final String place;
  final String role;
  final String company;
  final String summary;
  final List<String> bullets;
  final List<String> metrics;
  final bool isEducation;
  final bool isCurrent;

  const _TimelineEntry({
    required this.period,
    required this.place,
    required this.role,
    required this.company,
    required this.summary,
    required this.bullets,
    required this.metrics,
    this.isEducation = false,
    this.isCurrent = false,
  });
}

class _TimelineItem extends StatelessWidget {
  final _TimelineEntry entry;
  final bool wide;
  final bool isFirst;
  final bool isLast;

  const _TimelineItem({
    required this.entry,
    required this.wide,
    required this.isFirst,
    required this.isLast,
  });

  static const _metaWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final railX = wide ? _metaWidth : 0.0;
    final padTop = isFirst ? 8.0 : 32.0;
    final titleSize = AppType.fluid(context, 21, 24);

    final meta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.period,
          style: AppType.ui(context, size: 15).copyWith(
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 4),
        Text(entry.place, style: AppType.caption(context)),
      ],
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: entry.role,
                style: AppType.h3(context, size: titleSize),
              ),
              TextSpan(
                text: '  ·  ${entry.company}',
                style: AppType.h3(
                  context,
                  size: titleSize,
                ).copyWith(color: p.inkMuted, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 704),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.summary,
                style: AppType.body(
                  context,
                  size: 16.5,
                ).copyWith(color: entry.isEducation ? p.inkFaint : p.ink),
              ),
              if (entry.bullets.isNotEmpty) ...[
                const SizedBox(height: 14),
                DashList(entry.bullets),
              ],
            ],
          ),
        ),
        if (entry.metrics.isNotEmpty) ...[
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [for (final m in entry.metrics) _MetricTag(m)],
          ),
        ],
      ],
    );

    return HoverRegion(
      builder: (context, hovered) {
        final filled = !entry.isEducation && (entry.isCurrent || hovered);
        final node = AnimatedContainer(
          duration: Space.fast,
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? p.signal : p.ground,
            border: Border.all(
              color: entry.isEducation ? p.inkFaint : p.accentInk,
            ),
          ),
        );

        return Container(
          decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(bottom: BorderSide(color: p.lineFaint)),
          ),
          child: Stack(
            children: [
              // The rail: one segment per row, edge to edge, so the rows
              // join into a single continuous line.
              Positioned(
                left: railX,
                top: isFirst ? padTop + 8 : 0,
                bottom: isLast ? null : 0,
                height: isLast ? padTop + 8 : null,
                child: Container(width: 1, color: p.line),
              ),
              Positioned(left: railX - 5, top: padTop + 8, child: node),
              Padding(
                padding: EdgeInsets.only(top: padTop, bottom: 32),
                child: wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _metaWidth,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 32),
                              child: meta,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: body,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [meta, const SizedBox(height: 14), body],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Outcome tag: same pill shape as tech tags but drawn in the accent, so
/// results read differently from tools.
class _MetricTag extends StatelessWidget {
  final String text;

  const _MetricTag(this.text);

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Space.pill),
        border: Border.all(color: p.accentInk.withValues(alpha: 0.6)),
      ),
      child: Text(
        text,
        style: AppType.caption(context).copyWith(
          color: p.accentInk,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
