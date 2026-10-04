import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'motion.dart';

/// A full-bleed page section: faint top hairline, generous vertical rhythm,
/// content centred in a 1200px column with a fluid side gutter.
class Section extends StatelessWidget {
  final Widget child;
  final Color? background;
  final bool topRule;
  final double? paddingTop;
  final double? paddingBottom;

  /// When false, the child spans the full width (used for marquees); give
  /// its inner rows a [PageColumn] instead.
  final bool constrain;

  const Section({
    super.key,
    required this.child,
    this.background,
    this.topRule = true,
    this.paddingTop,
    this.paddingBottom,
    this.constrain = true,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final v = Space.section(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: background,
        border: topRule ? Border(top: BorderSide(color: p.lineFaint)) : null,
      ),
      padding: EdgeInsets.only(
        top: paddingTop ?? v,
        bottom: paddingBottom ?? v,
      ),
      child: constrain ? PageColumn(child: child) : child,
    );
  }
}

/// Centres [child] in the site's max-width column with the side gutter.
class PageColumn extends StatelessWidget {
  final Widget child;

  const PageColumn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final g = Space.gutter(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Space.maxWidth + g * 2),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: g),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Large section title (+ optional lead), revealed on scroll. The title is
/// announced as a heading. No eyebrow label above it: the heading carries
/// its own weight.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? lead;
  final double titleMaxWidth;

  /// Optional widget aligned to the title's baseline on wide screens (e.g.
  /// a "see all" link or a legend); stacks under the lead on narrow ones.
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.lead,
    this.titleMaxWidth = 820,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: titleMaxWidth),
            child: Semantics(
              header: true,
              child: Text(title, style: AppType.h2(context)),
            ),
          ),
        ),
        if (lead != null) ...[
          const SizedBox(height: 20),
          Reveal(
            delay: const Duration(milliseconds: 100),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(lead!, style: AppType.lead(context)),
            ),
          ),
        ],
      ],
    );
    return Padding(
      padding: EdgeInsets.only(bottom: AppType.fluid(context, 36, 64)),
      child: trailing == null
          ? heading
          : LayoutBuilder(
              builder: (context, c) => c.maxWidth > 800
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: heading),
                        const SizedBox(width: 32),
                        Reveal(child: trailing!),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading,
                        const SizedBox(height: 24),
                        Reveal(child: trailing!),
                      ],
                    ),
            ),
    );
  }
}

/// Wrapping row of small pill tags.
class TagList extends StatelessWidget {
  final List<String> tags;
  final bool onInverse;

  const TagList(this.tags, {super.key, this.onInverse = false});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final tag in tags)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
            decoration: BoxDecoration(
              color: p.surface,
              borderRadius: BorderRadius.circular(Space.pill),
              border: Border.all(color: p.line),
            ),
            child: Text(
              tag,
              style: AppType.caption(
                context,
              ).copyWith(color: p.inkMuted, fontSize: 12.5),
            ),
          ),
      ],
    );
  }
}

/// Bullet list with short accent dashes as markers.
class DashList extends StatelessWidget {
  final List<String> items;
  final TextStyle? style;

  const DashList(this.items, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final textStyle = style ?? AppType.body(context, size: 15.5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: (textStyle.fontSize ?? 16) * 0.8,
                  ),
                  child: Container(width: 8, height: 1, color: p.accentInk),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(item, style: textStyle)),
              ],
            ),
          ),
      ],
    );
  }
}

/// Lays children out in [columns] equal columns (computed from the
/// available width by [columnsFor]) with a [gap], rows sized to content.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int Function(double width) columnsFor;
  final double gap;
  final double runGap;

  /// Stretch every cell in a row to the tallest one. Only needed when a
  /// cell pins content to its bottom edge (e.g. project cards).
  final bool equalHeight;

  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.columnsFor,
    this.gap = Space.gap,
    this.equalHeight = false,
    double? runGap,
  }) : runGap = runGap ?? gap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = columnsFor(constraints.maxWidth).clamp(1, 12);
        final rows = <Widget>[];
        for (var i = 0; i < children.length; i += columns) {
          final slice = children.sublist(
            i,
            (i + columns).clamp(0, children.length),
          );
          final row = Row(
            crossAxisAlignment: equalHeight
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.start,
            children: [
              for (var j = 0; j < columns; j++) ...[
                if (j > 0) SizedBox(width: gap),
                Expanded(
                  child: j < slice.length ? slice[j] : const SizedBox.shrink(),
                ),
              ],
            ],
          );
          rows.add(equalHeight ? IntrinsicHeight(child: row) : row);
          if (i + columns < children.length) rows.add(SizedBox(height: runGap));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}
