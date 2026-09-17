import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _pillars = [
    _Pillar(
      icon: Icons.hub_outlined,
      title: 'Scale',
      body:
          'Built and maintained Flutter apps serving 3M+ active users across '
          'loyalty & rewards platforms, plus a large-scale healthcare application.',
    ),
    _Pillar(
      icon: Icons.speed_rounded,
      title: 'Performance',
      body:
          'Delivered up to 60% faster load times through caching, API '
          'optimization, and architecture refactors.',
    ),
    _Pillar(
      icon: Icons.shield_outlined,
      title: 'Security',
      body:
          'Applied threat modeling and healthcare-grade practices to protect '
          'against reverse engineering, runtime injection, and MiTM attacks.',
    ),
    _Pillar(
      icon: Icons.flag_outlined,
      title: 'Ownership',
      body:
          'Took Doam from architecture through delivery, and now lead Flutter '
          'engineering for a healthcare product at MEGAMIND IT Solutions.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'About',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: 24),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Text(
                  'I\'m a Senior Mobile Engineer with 6+ years building Android '
                  'and iOS applications, primarily in Flutter. I work across the '
                  'full lifecycle — architecture, performance, security, and '
                  'delivery — on products used by millions of people, and I '
                  'modernize legacy codebases into something a team can actually '
                  'scale. I pair that with an AI-augmented engineering workflow '
                  'to move faster without cutting corners on code quality.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                    color: textSecondary,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 48),

              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 820
                      ? 4
                      : constraints.maxWidth > 560
                      ? 2
                      : 1;
                  final itemWidth =
                      (constraints.maxWidth - (columns - 1) * 20) / columns;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      for (int i = 0; i < _pillars.length; i++)
                        SizedBox(
                          width: itemWidth,
                          child: _PillarCard(pillar: _pillars[i])
                              .animate()
                              .fadeIn(delay: (250 + i * 100).ms)
                              .slideY(begin: 0.15, end: 0),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pillar {
  final IconData icon;
  final String title;
  final String body;

  const _Pillar({required this.icon, required this.title, required this.body});
}

class _PillarCard extends StatefulWidget {
  final _Pillar pillar;

  const _PillarCard({required this.pillar});

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final pillar = widget.pillar;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0.0, 1.0),
        height: 190,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardColor(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? accent.withValues(alpha: 0.5)
                : AppTheme.borderColor(context),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(pillar.icon, color: accent, size: 22),
            ),
            const SizedBox(height: 14),
            Text(
              pillar.title,
              style: TextStyle(
                color: AppTheme.textColor(context),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                pillar.body,
                style: TextStyle(
                  color: AppTheme.textColorSecondary(context),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
