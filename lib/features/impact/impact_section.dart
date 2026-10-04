import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/motion.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/section.dart';

/// "Scale": active users per product drawn as one calibrated instrument —
/// every bar on a shared 0–4M axis, so the proportions are the argument.
/// Rows come straight from assets/config.json (`scaleLabel`); products
/// without a user figure are left out rather than estimated.
class ImpactSection extends StatefulWidget {
  const ImpactSection({super.key});

  @override
  State<ImpactSection> createState() => _ImpactSectionState();
}

class _Row {
  final String name;
  final String domain;
  final String label;
  final double millions;
  final String detail;

  /// Measured results from this product's own `impact` list, so each
  /// figure is read against the scale it was achieved at.
  final String outcomes;

  const _Row(
    this.name,
    this.domain,
    this.label,
    this.millions,
    this.detail,
    this.outcomes,
  );
}

class _ImpactSectionState extends State<ImpactSection> {
  static final _millions = RegExp(r'^([\d.]+)M\+');
  static final _percent = RegExp(r'^~?\d+%');
  List<_Row> _rows = const [];
  int? _focused;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = json.decode(await rootBundle.loadString('assets/config.json'));
    final rows = <_Row>[];
    for (final project in data['projects'] as List<dynamic>) {
      final label = project['scaleLabel'] as String?;
      final match = label == null ? null : _millions.firstMatch(label);
      if (match == null) continue;
      final context = (project['context'] as String? ?? '');
      final firstSentence = context.split(RegExp(r'(?<=\.)\s')).first;
      final impact = (project['impact'] as List<dynamic>? ?? []).cast<String>();
      final measured = impact.where(_percent.hasMatch).take(2).toList();
      final outcomes = measured.isNotEmpty
          ? measured.join('  ·  ')
          : impact.firstWhere((i) => !_millions.hasMatch(i), orElse: () => '');
      rows.add(
        _Row(
          project['name'] as String,
          project['domain'] as String? ?? '',
          label!.replaceAll(' users', ''),
          double.parse(match.group(1)!),
          firstSentence,
          outcomes,
        ),
      );
    }
    rows.sort((a, b) => b.millions.compareTo(a.millions));
    if (mounted) setState(() => _rows = rows);
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'Built for millions, measured in production.',
            lead:
                'Active users per product on one scale, each with the results '
                'measured there.',
          ),
          if (_rows.isNotEmpty) _chart(context),
        ],
      ),
    );
  }

  Widget _chart(BuildContext context) {
    final maxValue = _rows.first.millions.ceilToDouble();
    return LayoutBuilder(
      builder: (context, c) {
        final stacked = c.maxWidth <= 700;
        final nameW = stacked ? 0.0 : 220.0;
        return RevealBuilder(
          duration: const Duration(milliseconds: 1800),
          curve: Curves.linear,
          builder: (context, t) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < _rows.length; i++)
                _BarRow(
                  row: _rows[i],
                  max: maxValue,
                  nameWidth: nameW,
                  stacked: stacked,
                  t: ((t * 1.6) - i * 0.15).clamp(0.0, 1.0),
                  dimmed: _focused != null && _focused != i,
                  open: _focused == i,
                  onFocus: (on) => setState(() {
                    if (on) {
                      _focused = i;
                    } else if (_focused == i) {
                      _focused = null;
                    }
                  }),
                  onTap: () =>
                      setState(() => _focused = _focused == i ? null : i),
                ),
              Padding(
                padding: EdgeInsets.only(
                  left: nameW,
                  right: _labelRoom,
                  top: 10,
                ),
                child: _Axis(max: maxValue),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Space kept right of every track so the figure after the longest bar
/// never collides with it.
const _labelRoom = 76.0;

class _BarRow extends StatelessWidget {
  final _Row row;
  final double max;
  final double nameWidth;
  final bool stacked;
  final double t;
  final bool dimmed;
  final bool open;
  final ValueChanged<bool> onFocus;
  final VoidCallback onTap;

  const _BarRow({
    required this.row,
    required this.max,
    required this.nameWidth,
    required this.stacked,
    required this.t,
    required this.dimmed,
    required this.open,
    required this.onFocus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // Ballistic settle: a slight overshoot like a meter needle with mass,
    // clamped so the drawn bar never leaves its track.
    final grow = Curves.easeOutBack.transform(t);
    final barColor = dimmed ? Color.lerp(p.line, p.signal, 0.35)! : p.signal;

    final name = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          row.name,
          style: AppType.ui(context, size: 16).copyWith(
            fontWeight: FontWeight.w600,
            color: dimmed ? p.inkMuted : p.ink,
          ),
        ),
        const SizedBox(height: 3),
        Text(row.domain, style: AppType.caption(context)),
      ],
    );

    final track = Container(
      height: 44,
      padding: const EdgeInsets.only(right: _labelRoom),
      child: CustomPaint(
        painter: _ScaleGrid(color: p.line, max: max),
        child: LayoutBuilder(
          builder: (context, c) {
            final full = c.maxWidth * (row.millions / max);
            final w = (full * grow).clamp(0.0, c.maxWidth);
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  top: 16,
                  child: AnimatedContainer(
                    duration: Space.fast,
                    width: w,
                    height: 12,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(Space.pill),
                    ),
                  ),
                ),
                Positioned(
                  left: w + 12,
                  top: 6,
                  child: Opacity(
                    opacity: t,
                    child: _Figure(label: row.label, t: t, dimmed: dimmed),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    return Pressable(
      onTap: onTap,
      focusRadius: Space.radius,
      onActiveChanged: onFocus,
      semanticLabel:
          '${row.name}, ${row.label.replaceAll('M+', ' million plus')} users. '
          '${row.detail}',
      builder: (context, active) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: p.lineFaint)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (stacked) ...[
                name,
                const SizedBox(height: 4),
                track,
              ] else
                Row(
                  children: [
                    SizedBox(width: nameWidth, child: name),
                    Expanded(child: track),
                  ],
                ),
              if (row.outcomes.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: nameWidth, top: 2),
                  child: Text(
                    row.outcomes,
                    style: AppType.caption(context).copyWith(
                      fontSize: 13.5,
                      color: dimmed ? p.inkFaint : p.inkMuted,
                    ),
                  ),
                ),
              AnimatedSize(
                duration: Space.slow,
                curve: Space.expo,
                alignment: Alignment.topLeft,
                child: open
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: nameWidth,
                          top: 4,
                          bottom: 8,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 620),
                          child: Text(
                            row.detail,
                            style: AppType.body(context, size: 15),
                          ),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Figure extends StatelessWidget {
  final String label;
  final double t;
  final bool dimmed;

  const _Figure({required this.label, required this.t, required this.dimmed});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final match = RegExp(r'^([\d.]+)(.*)$').firstMatch(label)!;
    final target = double.parse(match.group(1)!);
    final decimals = match.group(1)!.contains('.') ? 1 : 0;
    final shown = (target * Space.expo.transform(t)).toStringAsFixed(decimals);
    return Text(
      '$shown${match.group(2)}',
      style: AppType.numeral(
        context,
        24,
      ).copyWith(color: dimmed ? p.inkFaint : p.ink),
    );
  }
}

/// Gridlines at every million, identical in every row so they read as one
/// continuous scale behind the bars.
class _ScaleGrid extends CustomPainter {
  final Color color;
  final double max;

  _ScaleGrid({required this.color, required this.max});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var m = 0; m <= max; m++) {
      final dx = (size.width * m / max).roundToDouble() + 0.5;
      canvas.drawLine(
        Offset(dx.clamp(0.5, size.width - 0.5), 0),
        Offset(dx.clamp(0.5, size.width - 0.5), size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ScaleGrid old) => old.color != color || old.max != max;
}

class _Axis extends StatelessWidget {
  final double max;

  const _Axis({required this.max});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: LayoutBuilder(
        builder: (context, c) => Stack(
          clipBehavior: Clip.none,
          children: [
            for (var m = 0; m <= max; m++)
              Positioned(
                left: c.maxWidth * m / max,
                child: FractionalTranslation(
                  translation: Offset(m == 0 ? 0 : (m == max ? -1 : -0.5), 0),
                  child: Text(
                    m == 0 ? '0' : '${m}M',
                    style: AppType.caption(context).copyWith(fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
