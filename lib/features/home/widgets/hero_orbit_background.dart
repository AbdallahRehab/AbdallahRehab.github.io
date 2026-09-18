import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Ambient "engineering system" motif behind the hero: a slow-drifting ring
/// of labeled nodes (the disciplines this engineer works across) connected
/// to a shared center, plus a soft glow that eases toward the pointer.
///
/// Nodes orbit continuously, but their opacity is gated by how close they
/// are to the horizontal axis — they're most visible beside the hero copy
/// and fade out as they swing past the top/bottom, so the motif never
/// competes with the name/role/metrics stacked down the vertical center.
///
/// [pointer] is a controlled value (fractional, -1..1) supplied by the
/// parent hero so this layer, the avatar, and anything else in the scene
/// react to the same cursor position as one coordinated parallax — the
/// ring (background) drifts opposite the cursor, the glow (mid-ground)
/// drifts with it.
///
/// Isolated in its own [RepaintBoundary] so the continuous rotation ticker
/// never forces the hero text/avatar above it to repaint — the only thing
/// animating every frame is this single painter. Hidden below desktop
/// widths, where there's no side margin for it to live in anyway.
class HeroOrbitBackground extends StatefulWidget {
  final Offset pointer;

  const HeroOrbitBackground({super.key, this.pointer = Offset.zero});

  @override
  State<HeroOrbitBackground> createState() => _HeroOrbitBackgroundState();
}

class _HeroOrbitBackgroundState extends State<HeroOrbitBackground>
    with TickerProviderStateMixin {
  static const _nodes = [
    'Flutter',
    'Architecture',
    'Performance',
    'Security',
    'Testing',
    'CI/CD',
    'Firebase',
    'API',
  ];

  late final AnimationController _driftController;
  late final AnimationController _entranceController;
  bool _reduceMotion = false;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _driftController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    );
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (!_started || reduceMotion != _reduceMotion) {
      _started = true;
      _reduceMotion = reduceMotion;
      if (_reduceMotion) {
        _driftController.stop();
        _entranceController.value = 1;
      } else {
        _driftController.repeat();
        _entranceController.forward();
      }
    }
  }

  @override
  void dispose() {
    _driftController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // No side margin to live in below this width — skip entirely rather
        // than crowd the hero copy on tablet/mobile.
        if (constraints.maxWidth < 900) return const SizedBox.shrink();

        final accent = AppTheme.primaryColor(context);
        final secondary = AppTheme.secondaryColor(context);
        final labelColor = AppTheme.textColorSecondary(context);

        return IgnorePointer(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: Listenable.merge([_driftController, _entranceController]),
              builder: (context, _) {
                return CustomPaint(
                  painter: _OrbitPainter(
                    progress: _driftController.value,
                    entrance: Curves.easeOutBack.transform(
                      _entranceController.value,
                    ),
                    pointer: widget.pointer,
                    nodes: _nodes,
                    accent: accent,
                    secondary: secondary,
                    labelColor: labelColor,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _OrbitPainter extends CustomPainter {
  final double progress;
  final double entrance;
  final Offset pointer;
  final List<String> nodes;
  final Color accent;
  final Color secondary;
  final Color labelColor;

  _OrbitPainter({
    required this.progress,
    required this.entrance,
    required this.pointer,
    required this.nodes,
    required this.accent,
    required this.secondary,
    required this.labelColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // The ring is the "background" layer — it drifts opposite the cursor,
    // a little less than the glow, for a two-plane parallax feel.
    final ringCenter = Offset(size.width / 2, size.height / 2) -
        Offset(pointer.dx * 16, pointer.dy * 16);
    final radius =
        min(size.width * 0.42, size.height * 0.55) * entrance.clamp(0.0, 1.2);

    // Pointer-reactive ambient glow — soft, cheap (single blurred circle),
    // the "mid-ground" layer, drifting with the cursor.
    final glowCenter = ringCenter + Offset(pointer.dx * 46, pointer.dy * 46);
    final glowPaint = Paint()
      ..color = accent.withValues(alpha: 0.07 * entrance)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90);
    canvas.drawCircle(glowCenter, radius * 0.85, glowPaint);

    // Rectangular "keep-out" zone matching the centered copy column — a
    // node is only drawn at full strength once it clears this box on
    // *either* axis, so it never lands behind the name/paragraph/metrics
    // no matter where the rotation or parallax drift puts it.
    final safeDx = min(410.0, size.width * 0.3);
    final safeDy = min(480.0, size.height * 0.52);
    const margin = 70.0;

    final angleOffset = progress * 2 * pi;
    for (int i = 0; i < nodes.length; i++) {
      final angle = angleOffset + (2 * pi * i / nodes.length);
      final ox = cos(angle) * radius;
      final oy = sin(angle) * radius;

      final clearX = ((ox.abs() - safeDx) / margin).clamp(0.0, 1.0);
      final clearY = ((oy.abs() - safeDy) / margin).clamp(0.0, 1.0);
      final visibility = max(clearX, clearY) * entrance;
      if (visibility < 0.02) continue;

      final nodeCenter = ringCenter + Offset(ox, oy);

      final linePaint = Paint()
        ..color = labelColor.withValues(alpha: 0.09 * visibility)
        ..strokeWidth = 1;
      canvas.drawLine(ringCenter, nodeCenter, linePaint);

      final isAccentNode = i.isEven;
      final dotPaint = Paint()
        ..color = (isAccentNode ? accent : secondary).withValues(
          alpha: 0.55 * visibility,
        );
      canvas.drawCircle(nodeCenter, 3.5, dotPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: nodes[i],
          style: TextStyle(
            color: labelColor.withValues(alpha: 0.4 * visibility),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final labelOffset = nodeCenter +
          Offset(
            (cos(angle) >= 0 ? 12 : -12 - textPainter.width),
            -textPainter.height / 2,
          );
      textPainter.paint(canvas, labelOffset);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.entrance != entrance ||
      oldDelegate.pointer != pointer ||
      oldDelegate.accent != accent ||
      oldDelegate.secondary != secondary;
}
