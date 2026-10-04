import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pressable.dart';

enum PillVariant {
  /// Lime fill, dark ink; ink sweeps in on hover. The primary action.
  accent,

  /// Ink outline on the ground; ink sweeps in on hover.
  outline,

  /// Dark fill for use on the inverse (contact) band; lime sweeps in.
  inverse,

  /// Outline for use on the inverse band.
  inverseOutline,
}

/// Full-pill button whose fill sweeps in from the left on hover/focus and
/// retracts to the right on leave.
class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final PillVariant variant;
  final IconData? icon;
  final bool large;
  final bool compact;
  final String? semanticLabel;

  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PillVariant.accent,
    this.icon,
    this.large = false,
    this.compact = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (
      Color bg,
      Color fg,
      Color border,
      Color sweep,
      Color sweepFg,
    ) = switch (variant) {
      PillVariant.accent => (p.accent, p.onAccent, p.accent, p.ink, p.ground),
      PillVariant.outline => (
        Colors.transparent,
        p.ink,
        p.ink,
        p.ink,
        p.ground,
      ),
      PillVariant.inverse => (
        p.onInverse,
        p.inverse,
        p.onInverse,
        p.accent,
        p.onAccent,
      ),
      PillVariant.inverseOutline => (
        Colors.transparent,
        p.onInverse,
        p.onInverse,
        p.onInverse,
        p.inverse,
      ),
    };

    final padding = compact
        ? const EdgeInsets.symmetric(horizontal: 18, vertical: 13)
        : large
        ? const EdgeInsets.symmetric(horizontal: 28, vertical: 17)
        : const EdgeInsets.symmetric(horizontal: 22, vertical: 13);
    final fontSize = large ? 16.0 : (compact ? 14.0 : 15.0);

    return Pressable(
      onTap: onPressed,
      semanticLabel: semanticLabel ?? label,
      builder: (context, active) => ClipRRect(
        borderRadius: BorderRadius.circular(Space.pill),
        child: Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(Space.pill),
            border: Border.all(color: border),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedFractionallySizedBox(
                  duration: Space.slow,
                  curve: Space.expo,
                  alignment: active
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  widthFactor: active ? 1 : 0,
                  heightFactor: 1,
                  child: ColoredBox(color: sweep),
                ),
              ),
              Padding(
                padding: padding,
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: active ? sweepFg : fg),
                  duration: Space.slow,
                  curve: Space.expo,
                  builder: (context, color, _) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: fontSize + 3, color: color),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          label,
                          style: AppType.ui(
                            context,
                            size: fontSize,
                          ).copyWith(color: color),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The recurring "go" motif: a lime circle holding a north-east arrow that
/// turns to point straight ahead when its parent is active.
class ArrowCircle extends StatelessWidget {
  final bool active;
  final double size;
  final bool outlined;

  const ArrowCircle({
    super.key,
    this.active = false,
    this.size = 44,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AnimatedContainer(
      duration: Space.slow,
      curve: Space.expo,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: outlined ? Colors.transparent : p.accent,
        border: outlined
            ? Border.all(color: active ? p.accentInk : p.line)
            : null,
      ),
      child: AnimatedRotation(
        turns: active ? 0.125 : 0,
        duration: Space.slow,
        curve: Space.expo,
        child: Icon(
          Icons.north_east_rounded,
          size: size * 0.42,
          color: outlined ? (active ? p.accentInk : p.ink) : p.onAccent,
        ),
      ),
    );
  }
}

/// A tappable [ArrowCircle] on its own (e.g. hero "scroll to next").
class ArrowCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String semanticLabel;
  final double size;
  final bool outlined;

  const ArrowCircleButton({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    this.size = 44,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onPressed,
      semanticLabel: semanticLabel,
      builder: (context, active) =>
          ArrowCircle(active: active, size: size, outlined: outlined),
    );
  }
}

/// Circular outlined icon button (theme toggle, socials, menu).
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;
  final double size;
  final bool onInverse;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.size = 40,
    this.onInverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final idle = onInverse ? p.onInverse.withValues(alpha: 0.25) : p.line;
    final fg = onInverse ? p.onInverse : p.ink;
    final hot = onInverse ? p.onInverse : p.accentInk;
    return Tooltip(
      message: semanticLabel,
      child: Pressable(
        onTap: onPressed,
        semanticLabel: semanticLabel,
        builder: (context, active) => SizedBox.square(
          // Hit area never below 44px; the drawn circle keeps its size.
          dimension: size < 44 ? 44 : size,
          child: Center(
            child: AnimatedContainer(
              duration: Space.fast,
              curve: Space.easeOut,
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: active ? hot : idle),
              ),
              child: Icon(icon, size: size * 0.42, color: active ? hot : fg),
            ),
          ),
        ),
      ),
    );
  }
}

/// Text link with an accent underline that grows in on hover.
class InlineLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final TextStyle? style;
  final Color? underline;

  const InlineLink({
    super.key,
    required this.label,
    required this.onTap,
    this.style,
    this.underline,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final base = style ?? AppType.ui(context);
    return Pressable(
      onTap: onTap,
      isLink: true,
      focusRadius: 4,
      semanticLabel: label,
      // The underline is positioned against the text's own width, so the
      // link works inside unbounded rows too.
      builder: (context, active) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(label, style: base),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedFractionallySizedBox(
              alignment: Alignment.centerLeft,
              duration: Space.slow,
              curve: Space.expo,
              widthFactor: active ? 1 : 0,
              child: Container(height: 1, color: underline ?? p.accentInk),
            ),
          ),
        ],
      ),
    );
  }
}
