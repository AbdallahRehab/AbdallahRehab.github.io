import 'package:flutter/material.dart';

/// Gates entrance/decorative motion behind the platform's reduced-motion
/// preference. When reduced motion is requested, returns the widget
/// unchanged — fully visible immediately, no fade/slide/scale choreography
/// — instead of running [animate]. Mirrors the pattern already used by
/// `AnimatedMetric` and `HeroOrbitBackground` for their own tickers, applied
/// once here so every `flutter_animate` call site doesn't repeat the check.
extension MotionAware on Widget {
  Widget animatedUnlessReduced(
    BuildContext context,
    Widget Function(Widget child) animate,
  ) {
    return MediaQuery.of(context).disableAnimations ? this : animate(this);
  }
}
