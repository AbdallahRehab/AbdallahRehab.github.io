import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'buttons.dart';
import 'section.dart';

class Footer extends StatelessWidget {
  final VoidCallback onBackToTop;

  const Footer({super.key, required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final identity = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Abdallah Ali Rehab',
            style: AppType.ui(context, size: 15).copyWith(color: p.ink),
          ),
          TextSpan(
            text: '  ·  Senior Mobile Engineer, Flutter',
            style: AppType.caption(
              context,
            ).copyWith(fontSize: 14, color: p.inkMuted),
          ),
        ],
      ),
    );
    final meta = Text(
      '© ${DateTime.now().year} · Built with Flutter Web',
      // inkMuted, not inkFaint: the recessed footer ground is too close to
      // inkFaint in light mode for small text.
      style: AppType.caption(context).copyWith(color: p.inkMuted),
    );
    final top = CircleIconButton(
      icon: Icons.arrow_upward_rounded,
      onPressed: onBackToTop,
      semanticLabel: 'Back to top',
    );

    return Container(
      color: p.recessed,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: PageColumn(
        child: LayoutBuilder(
          builder: (context, c) => c.maxWidth > 700
              ? Row(
                  children: [
                    Expanded(child: identity),
                    meta,
                    const SizedBox(width: 20),
                    top,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [identity, const SizedBox(height: 8), meta],
                      ),
                    ),
                    top,
                  ],
                ),
        ),
      ),
    );
  }
}
