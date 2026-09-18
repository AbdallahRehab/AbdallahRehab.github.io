import 'package:flutter/material.dart';

/// Animates a leading integer (e.g. "60" in "60%") counting up from zero,
/// then settles on the metric's full label including its suffix. Values
/// with no leading digit (e.g. "iOS · Android") just render as static text.
/// Shared between the hero strip and the impact section so both read the
/// same numbers the same way.
class AnimatedMetric extends StatelessWidget {
  static final _leadingNumber = RegExp(r'^(\d+)(.*)$');

  final String value;
  final String label;
  final Color valueColor;
  final Color labelColor;
  final double valueSize;
  final double labelSize;

  const AnimatedMetric({
    super.key,
    required this.value,
    required this.label,
    required this.valueColor,
    required this.labelColor,
    this.valueSize = 22,
    this.labelSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    final match = _leadingNumber.firstMatch(value);
    final valueStyle = TextStyle(
      color: valueColor,
      fontSize: valueSize,
      fontWeight: FontWeight.bold,
    );
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (match != null && !reduceMotion)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: double.parse(match.group(1)!)),
            duration: const Duration(milliseconds: 1400),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) =>
                Text('${animatedValue.toInt()}${match.group(2)}', style: valueStyle),
          )
        else
          Text(value, style: valueStyle),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: labelColor, fontSize: labelSize),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
