import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

/// A standalone section for AI-assisted engineering — framed as an
/// accelerator layered on top of engineering judgment, not a replacement
/// for it, matching how it's positioned on the CV.
class AiAssistedSection extends StatelessWidget {
  const AiAssistedSection({super.key});

  static const _capabilities = [
    _Capability(
      icon: Icons.code_rounded,
      title: 'Coding & Refactoring',
      body: 'Faster iteration on widgets, state logic, and cleanup passes.',
    ),
    _Capability(
      icon: Icons.bug_report_outlined,
      title: 'Debugging & Crash Analysis',
      body: 'Faster root-causing of runtime issues and Sentry/crash logs.',
    ),
    _Capability(
      icon: Icons.hub_outlined,
      title: 'Architecture Brainstorming',
      body: 'A sounding board for weighing structural trade-offs early.',
    ),
    _Capability(
      icon: Icons.fact_check_outlined,
      title: 'Test & Doc Generation',
      body: 'Boilerplate for unit/widget tests and documentation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);
    final accent = AppTheme.primaryColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accent.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'AI-ASSISTED ENGINEERING',
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: 24),

              Text(
                'An accelerator, not a replacement for engineering judgment',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 16),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  'I use AI tooling as part of a deliberate workflow — it '
                  'speeds up the mechanical parts of the job so more time '
                  'goes toward architecture, performance, and the calls '
                  'only an engineer who understands the product can make.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textSecondary, height: 1.6),
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
                      for (int i = 0; i < _capabilities.length; i++)
                        SizedBox(
                          width: itemWidth,
                          child: _CapabilityCard(capability: _capabilities[i])
                              .animate()
                              .fadeIn(delay: (250 + i * 80).ms)
                              .slideY(begin: 0.12, end: 0),
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

class _Capability {
  final IconData icon;
  final String title;
  final String body;

  const _Capability({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class _CapabilityCard extends StatefulWidget {
  final _Capability capability;

  const _CapabilityCard({required this.capability});

  @override
  State<_CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<_CapabilityCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final capability = widget.capability;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0.0, 1.0),
        height: 170,
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
              child: Icon(capability.icon, color: accent, size: 22),
            ),
            const SizedBox(height: 14),
            Text(
              capability.title,
              style: TextStyle(
                color: AppTheme.textColor(context),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                capability.body,
                style: TextStyle(
                  color: AppTheme.textColorSecondary(context),
                  fontSize: 12.5,
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
