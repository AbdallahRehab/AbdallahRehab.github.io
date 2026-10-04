import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/motion.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _pillars = [
    _Pillar(
      title: 'Scale',
      body:
          'Built and maintained Flutter apps serving 3M+ active users across '
          'loyalty & rewards platforms, plus a large-scale healthcare application.',
    ),
    _Pillar(
      title: 'Performance',
      body:
          'Delivered up to 60% faster load times through caching, API '
          'optimization, and architecture refactors.',
    ),
    _Pillar(
      title: 'Security',
      body:
          'Applied threat modeling and healthcare-grade practices to protect '
          'against reverse engineering, runtime injection, and MiTM attacks.',
    ),
    _Pillar(
      title: 'Ownership',
      body:
          'Took Doam from architecture through delivery, and now lead Flutter '
          'engineering for a healthcare product at MEGAMIND IT Solutions.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'The full lifecycle, from architecture to app store.',
            titleMaxWidth: 760,
          ),
          LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth > 900;
              const prose = Reveal(child: _Prose());
              const chart = Reveal(
                delay: Duration(milliseconds: 120),
                child: _CareerChart(),
              );
              final pillars = _PillarGrid(pillars: _pillars);
              if (!wide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    prose,
                    const SizedBox(height: 56),
                    chart,
                    const SizedBox(height: 56),
                    pillars,
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(flex: 11, child: prose),
                      SizedBox(width: AppType.fluid(context, 40, 96)),
                      const Expanded(flex: 12, child: chart),
                    ],
                  ),
                  const SizedBox(height: 72),
                  pillars,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Prose extends StatelessWidget {
  const _Prose();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final base = AppType.body(context, size: 17.5).copyWith(height: 1.7);
    final strong = base.copyWith(color: p.ink, fontWeight: FontWeight.w600);
    TextSpan s(String t, [bool b = false]) =>
        TextSpan(text: t, style: b ? strong : base);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                s("I'm a Senior Mobile Engineer with "),
                s('6+ years', true),
                s(
                  ' building Android and iOS applications, primarily in '
                  'Flutter. I work across the full lifecycle — architecture, '
                  'performance, security, and delivery — on products used by ',
                ),
                s('millions of people', true),
                s('.'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text.rich(
            TextSpan(
              children: [
                s(
                  'I modernize legacy codebases into something a team can '
                  'actually scale, and pair that with an ',
                ),
                s('AI-augmented engineering workflow', true),
                s(' to move faster without cutting corners on code quality.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Period {
  final String name;
  final String when;
  final String spoken;
  final double start;
  final double end;
  final bool education;
  final bool isNow;

  const _Period(
    this.name,
    this.when,
    this.spoken,
    this.start,
    this.end, {
    this.education = false,
    this.isNow = false,
  });
}

/// The career drawn to scale: one row per chapter on a shared 2016 → now
/// axis, bars warming from hairline toward lime as the career moves forward.
class _CareerChart extends StatelessWidget {
  const _CareerChart();

  static const _axisStart = 2016.0;
  static const _axisEnd = 2026.75; // Sep 2026, "now".

  static const _periods = [
    _Period(
      'Menoufiya Univ.',
      '16–20',
      'B.Sc. Computer Science, Menoufiya University, 2016 to 2020',
      2016,
      2020.5,
      education: true,
    ),
    _Period(
      'WEDDnGO',
      '20–22',
      'WEDDnGO, December 2020 to December 2022',
      2020.92,
      2022.92,
    ),
    _Period(
      'WalaPlus',
      '22–25',
      'WalaPlus, December 2022 to October 2025',
      2022.92,
      2025.8,
    ),
    _Period(
      'MEGAMIND',
      '25–now',
      'MEGAMIND IT Solutions, November 2025 to present',
      2025.84,
      _axisEnd,
      isNow: true,
    ),
  ];

  static double _x(double year) =>
      (year - _axisStart) / (_axisEnd - _axisStart);

  @override
  Widget build(BuildContext context) {
    const nameW = 112.0;
    const whenW = 56.0;
    const gap = 14.0;

    return RevealBuilder(
      duration: const Duration(milliseconds: 1600),
      curve: Curves.linear,
      builder: (context, t) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CountUpText(
                value: '6+',
                t: Space.expo.transform(t),
                style: AppType.numeral(context, AppType.fluid(context, 60, 80)),
              ),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'Years shipping\nmobile apps',
                  style: AppType.caption(context).copyWith(fontSize: 13.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          for (var i = 0; i < _periods.length; i++)
            _ChartRow(
              period: _periods[i],
              index: i,
              t: Space.expo.transform(((t * 1.5) - i * 0.14).clamp(0.0, 1.0)),
              nameW: nameW,
              whenW: whenW,
              gap: gap,
              x: _x,
              warmth: _periods[i].isNow
                  ? 1
                  : _periods[i].education
                  ? 0
                  : 0.35 + i * 0.2,
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
              left: nameW + gap,
              right: whenW + gap,
            ),
            child: SizedBox(
              height: 16,
              child: LayoutBuilder(
                builder: (context, c) {
                  final ticks = <(String, double)>[
                    ('2016', 2016),
                    if (c.maxWidth > 260) ('2018', 2018),
                    ('2020', 2020),
                    if (c.maxWidth > 260) ('2022', 2022),
                    ('2024', 2024),
                    ('Now', _axisEnd),
                  ];
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (final (label, year) in ticks)
                        Positioned(
                          left: c.maxWidth * _x(year),
                          child: FractionalTranslation(
                            translation: Offset(
                              year == _axisEnd ? -1 : (year == 2016 ? 0 : -0.5),
                              0,
                            ),
                            child: Text(
                              label,
                              style: AppType.caption(
                                context,
                              ).copyWith(fontSize: 11.5),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartRow extends StatelessWidget {
  final _Period period;
  final int index;
  final double t;
  final double nameW;
  final double whenW;
  final double gap;
  final double Function(double) x;
  final double warmth;

  const _ChartRow({
    required this.period,
    required this.index,
    required this.t,
    required this.nameW,
    required this.whenW,
    required this.gap,
    required this.x,
    required this.warmth,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final barColor = Color.lerp(p.line, p.signal, warmth)!;
    return Semantics(
      label: period.spoken,
      excludeSemantics: true,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            SizedBox(
              width: nameW,
              child: Text(
                period.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppType.ui(context, size: 14).copyWith(
                  color: period.isNow ? p.ink : p.inkMuted,
                  fontWeight: period.isNow ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: CustomPaint(
                painter: _GridPainter(color: p.line, x: x),
                child: LayoutBuilder(
                  builder: (context, c) {
                    final left = c.maxWidth * x(period.start);
                    final full = c.maxWidth * (x(period.end) - x(period.start));
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: left,
                          top: 15,
                          child: Container(
                            width: (full * t).clamp(0.0, full),
                            height: 10,
                            decoration: BoxDecoration(
                              color: period.education ? null : barColor,
                              borderRadius: BorderRadius.circular(Space.pill),
                              border: period.education
                                  ? Border.all(color: p.inkFaint)
                                  : null,
                            ),
                          ),
                        ),
                        if (period.isNow && t > 0.98)
                          Positioned(
                            left: left + full - 9,
                            top: 15,
                            child: const _PulseDot(),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: gap),
            SizedBox(
              width: whenW,
              child: Text(
                period.when,
                textAlign: TextAlign.right,
                style: AppType.caption(context).copyWith(
                  color: period.isNow ? p.accentInk : p.inkFaint,
                  fontWeight: period.isNow ? FontWeight.w600 : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vertical gridlines every two years plus the right edge, painted per row
/// at identical x positions so they read as one continuous grid.
class _GridPainter extends CustomPainter {
  final Color color;
  final double Function(double) x;

  _GridPainter({required this.color, required this.x});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (final year in [2016.0, 2018.0, 2020.0, 2022.0, 2024.0, 2026.0]) {
      final dx = (size.width * x(year)).roundToDouble() + 0.5;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
    final edge = size.width - 0.5;
    canvas.drawLine(Offset(edge, 0), Offset(edge, size.height), paint);
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.color != color;
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = context.palette.signal;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = Space.easeOut.transform(_c.value);
        return Transform.scale(
          scale: 1 + 1.4 * t,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: a.withValues(alpha: 0.7 * (1 - t)),
            ),
          ),
        );
      },
    );
  }
}

class _Pillar {
  final String title;
  final String body;

  const _Pillar({required this.title, required this.body});
}

/// The four working principles as a ruled definition list, not cards. The
/// rule above an item draws in lime on hover.
class _PillarGrid extends StatelessWidget {
  final List<_Pillar> pillars;

  const _PillarGrid({required this.pillars});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      gap: AppType.fluid(context, 24, 40),
      runGap: 8,
      columnsFor: (w) => w > 1000 ? 4 : (w > 560 ? 2 : 1),
      children: [
        for (var i = 0; i < pillars.length; i++)
          Reveal(
            delay: Duration(milliseconds: 80 * i),
            child: _PillarItem(pillar: pillars[i]),
          ),
      ],
    );
  }
}

class _PillarItem extends StatelessWidget {
  final _Pillar pillar;

  const _PillarItem({required this.pillar});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return HoverRegion(
      builder: (context, hovered) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(height: 1, color: p.line),
              AnimatedFractionallySizedBox(
                alignment: Alignment.centerLeft,
                duration: Space.slow,
                curve: Space.expo,
                widthFactor: hovered ? 1 : 0.12,
                child: Container(height: 1, color: p.accentInk),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(pillar.title, style: AppType.h3(context, size: 22)),
          const SizedBox(height: 10),
          Text(pillar.body, style: AppType.body(context, size: 15)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
