import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Gates entrance/decorative motion behind the platform's reduced-motion
/// preference. When reduced motion is requested, returns the widget
/// unchanged instead of running [animate].
extension MotionAware on Widget {
  Widget animatedUnlessReduced(
    BuildContext context,
    Widget Function(Widget child) animate,
  ) {
    return MediaQuery.of(context).disableAnimations ? this : animate(this);
  }
}

/// Runs [builder] with an eased 0→1 progress value that starts the first
/// time this widget scrolls into the viewport (and never reverses). The
/// whole page lives in one scroll view, so load-time entrance animations
/// would all fire off-screen; this ties each one to the moment it is seen.
///
/// Under reduced motion, [builder] receives 1.0 immediately.
class RevealBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, double t) builder;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  /// Fraction of the viewport height the widget's top must cross before
  /// it reveals (0.9 = when its top reaches 90% down the screen).
  final double threshold;

  const RevealBuilder({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 900),
    this.delay = Duration.zero,
    this.curve = Space.expo,
    this.threshold = 0.92,
  });

  @override
  State<RevealBuilder> createState() => _RevealBuilderState();
}

class _RevealBuilderState extends State<RevealBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _curved = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );
  ScrollPosition? _position;
  bool _triggered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _triggered = true;
      _controller.value = 1;
      return;
    }
    final next = Scrollable.maybeOf(context)?.position;
    if (next != _position) {
      _position?.removeListener(_check);
      _position = next;
      _position?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    if (top < viewport * widget.threshold) {
      _triggered = true;
      _position?.removeListener(_check);
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curved,
      builder: (context, _) => widget.builder(context, _curved.value),
    );
  }
}

/// The standard entrance: fade up a short distance once scrolled into view.
class Reveal extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final double offset;

  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 24,
  });

  @override
  Widget build(BuildContext context) {
    return RevealBuilder(
      delay: delay,
      builder: (context, t) => Opacity(
        // Faded-out content stays in the semantics tree, so screen readers
        // reach every section before it has been scrolled into view.
        alwaysIncludeSemantics: true,
        opacity: t.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, (1 - t) * offset),
          child: child,
        ),
      ),
    );
  }
}

/// Renders a metric like "7M+" or "60%" counting its leading integer up to
/// the final value as [t] goes 0→1. Values without a leading integer render
/// unchanged.
class CountUpText extends StatelessWidget {
  static final _leadingNumber = RegExp(r'^(\d+)(.*)$');

  final String value;
  final double t;
  final TextStyle style;

  const CountUpText({
    super.key,
    required this.value,
    required this.t,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final match = _leadingNumber.firstMatch(value);
    if (match == null) return Text(value, style: style);
    final target = int.parse(match.group(1)!);
    final shown = (target * t).round();
    return Semantics(
      label: value,
      excludeSemantics: true,
      child: Text('$shown${match.group(2)}', style: style),
    );
  }
}

/// Mutes every ticker below it (looping marquees, pulsing dots) while it
/// is scrolled out of the viewport, so ambient motion costs nothing once
/// nobody can see it. Controllers resume where they left off.
class InViewport extends StatefulWidget {
  final Widget child;

  const InViewport({super.key, required this.child});

  @override
  State<InViewport> createState() => _InViewportState();
}

class _InViewportState extends State<InViewport> {
  ScrollPosition? _position;
  bool _visible = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final next = Scrollable.maybeOf(context)?.position;
    if (next != _position) {
      _position?.removeListener(_check);
      _position = next;
      _position?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    final visible = top < viewport && top + box.size.height > 0;
    if (visible != _visible) setState(() => _visible = visible);
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      TickerMode(enabled: _visible, child: widget.child);
}
