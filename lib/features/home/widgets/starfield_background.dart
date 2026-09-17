import 'dart:math';
import 'package:flutter/material.dart';

/// A single, precomputed starfield. Deliberately static (no ticker, no
/// per-frame repaint) — the animated 200-star version cost continuous
/// CPU/GPU work for a purely decorative background, which works against
/// both performance and the "avoid distracting backgrounds" design goal.
/// Only visible in dark mode; the light theme reads better on a plain
/// surface.
class StarfieldBackground extends StatelessWidget {
  const StarfieldBackground({super.key});

  static final List<Star> _stars = _generateStars(90);

  static List<Star> _generateStars(int count) {
    final random = Random(42);
    return List.generate(
      count,
      (_) => Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 1.6 + 0.4,
        opacity: random.nextDouble() * 0.5 + 0.15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness != Brightness.dark) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(painter: StarPainter(_stars), size: Size.infinite),
      ),
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;

  const Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
  });
}

class StarPainter extends CustomPainter {
  final List<Star> stars;

  const StarPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (final star in stars) {
      paint.color = Colors.white.withValues(alpha: star.opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => false;
}
