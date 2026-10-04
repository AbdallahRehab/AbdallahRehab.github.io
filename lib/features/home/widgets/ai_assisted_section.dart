import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section.dart';

/// AI-assisted engineering — framed as an accelerator layered on top of
/// engineering judgment, not a replacement for it, matching the CV. A
/// quieter typographic interlude between the dense sections.
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
    final p = context.palette;
    final h2 = AppType.h2(context);

    final statement = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Semantics(
            header: true,
            headingLevel: 2,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'An accelerator, not a replacement for ',
                    style: h2,
                  ),
                  TextSpan(
                    text: 'engineering judgment.',
                    style: h2.copyWith(color: p.accentInk),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Reveal(
          delay: const Duration(milliseconds: 100),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              'I use AI tooling as part of a deliberate workflow — it speeds '
              'up the mechanical parts of the job so more time goes toward '
              'architecture, performance, and the calls only an engineer who '
              'understands the product can make.',
              style: AppType.lead(context),
            ),
          ),
        ),
      ],
    );

    final list = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < _capabilities.length; i++)
          Reveal(
            delay: Duration(milliseconds: 80 * i),
            child: _CapabilityRow(capability: _capabilities[i]),
          ),
      ],
    );

    return Section(
      child: LayoutBuilder(
        builder: (context, c) => c.maxWidth > 900
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 10, child: statement),
                  SizedBox(width: AppType.fluid(context, 40, 96)),
                  Expanded(flex: 9, child: list),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [statement, const SizedBox(height: 48), list],
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

class _CapabilityRow extends StatelessWidget {
  final _Capability capability;

  const _CapabilityRow({required this.capability});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return HoverRegion(
      builder: (context, hovered) => Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: p.line)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    capability.title,
                    style: AppType.ui(context, size: 16).copyWith(
                      fontWeight: FontWeight.w600,
                      color: hovered ? p.accentInk : p.ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(capability.body, style: AppType.body(context, size: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
