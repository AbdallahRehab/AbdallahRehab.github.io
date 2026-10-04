import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

/// A keyboard-focusable, screen-reader-labelled tap target that reports its
/// hover and focus state to [builder]. Every interactive element on the site
/// goes through this so pointer, keyboard (Enter/Space) and assistive tech
/// get the same affordance, and focus always draws the same ring.
class Pressable extends StatefulWidget {
  final Widget Function(BuildContext context, bool active) builder;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool isLink;

  /// Called when hover-or-focus turns on or off.
  final ValueChanged<bool>? onActiveChanged;

  /// Radius of the focus ring drawn around the child.
  final double focusRadius;

  const Pressable({
    super.key,
    required this.builder,
    this.onTap,
    this.semanticLabel,
    this.isLink = false,
    this.onActiveChanged,
    this.focusRadius = Space.pill,
  });

  /// Convenience for outbound links.
  static void open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _hovered = false;
  bool _focused = false;

  void _update({bool? hovered, bool? focused}) {
    final was = _hovered || _focused;
    setState(() {
      _hovered = hovered ?? _hovered;
      _focused = focused ?? _focused;
    });
    final now = _hovered || _focused;
    if (now != was) widget.onActiveChanged?.call(now);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final active = _hovered || _focused;
    return Semantics(
      button: !widget.isLink,
      link: widget.isLink,
      label: widget.semanticLabel,
      child: FocusableActionDetector(
        mouseCursor: widget.onTap != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        onShowHoverHighlight: (v) => _update(hovered: v),
        onShowFocusHighlight: (v) => _update(focused: v),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onTap?.call();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.focusRadius),
              border: Border.all(
                color: _focused ? p.accentInk : Colors.transparent,
                width: 1.5,
                strokeAlign: 3,
              ),
            ),
            child: widget.builder(context, active),
          ),
        ),
      ),
    );
  }
}

/// Tracks hover for non-interactive visuals (rows, cards without a single
/// action) without taking focus.
class HoverRegion extends StatefulWidget {
  final Widget Function(BuildContext context, bool hovered) builder;

  const HoverRegion({super.key, required this.builder});

  @override
  State<HoverRegion> createState() => _HoverRegionState();
}

class _HoverRegionState extends State<HoverRegion> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(context, _hovered),
    );
  }
}
