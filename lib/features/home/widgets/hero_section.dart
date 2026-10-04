import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/site_links.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section.dart';

/// First viewport: the name at poster scale, revealed line by line from
/// behind a mask, beside a 4:5 portrait. A quiet ledger line underneath
/// says where the work happens now and where it happened before.
class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _intro.value = 1;
    } else if (!_intro.isAnimating && _intro.value == 0) {
      _intro.forward();
    }
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  /// Eased progress of one step of the intro, [start]..[end] in 0..1 of
  /// the whole sequence.
  double _step(double start, double end) => Space.expo.transform(
    ((_intro.value - start) / (end - start)).clamp(0.0, 1.0),
  );

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.sizeOf(context).height;

    return Container(
      constraints: BoxConstraints(
        minHeight: (viewport - 72).clamp(560.0, 940.0),
      ),
      padding: EdgeInsets.only(
        top: AppType.fluid(context, 24, 48),
        bottom: AppType.fluid(context, 40, 56),
      ),
      child: PageColumn(
        child: AnimatedBuilder(
          animation: _intro,
          builder: (context, _) => LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth > 900;
              final text = _HeroText(
                step: _step,
                onViewWork: widget.onViewWork,
                onContact: widget.onContact,
              );
              final photo = Opacity(
                // Faded-out content stays in the semantics tree, so screen readers
                // reach every section before it has been scrolled into view.
                alwaysIncludeSemantics: true,
                opacity: _step(0.0, 0.5),
                child: _Portrait(settle: _step(0.0, 0.9)),
              );
              final ledger = Opacity(
                alwaysIncludeSemantics: true,
                opacity: _step(0.55, 1),
                child: const _Ledger(),
              );

              if (!wide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text,
                    const SizedBox(height: 48),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: photo,
                    ),
                    const SizedBox(height: 40),
                    ledger,
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 125, child: text),
                      SizedBox(width: AppType.fluid(context, 40, 88)),
                      Expanded(
                        flex: 100,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 440),
                            child: photo,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ledger,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final double Function(double start, double end) step;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const _HeroText({
    required this.step,
    required this.onViewWork,
    required this.onContact,
  });

  /// One line of the name, sliding up from behind its own mask.
  Widget _line(String text, TextStyle style, double t) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        heightFactor: 1,
        child: FractionalTranslation(
          translation: Offset(0, 1.05 * (1 - t)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(text, style: style),
          ),
        ),
      ),
    );
  }

  Widget _fadeUp(double t, Widget child) => Opacity(
    alwaysIncludeSemantics: true,
    opacity: t,
    child: Transform.translate(offset: Offset(0, 16 * (1 - t)), child: child),
  );

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final style = AppType.hero(context);
    final socials = <(IconData, String, String)>[
      (FontAwesomeIcons.linkedinIn.data, SiteLinks.linkedIn, 'LinkedIn'),
      (FontAwesomeIcons.github.data, SiteLinks.gitHub, 'GitHub'),
      (FontAwesomeIcons.xTwitter.data, SiteLinks.x, 'X (Twitter)'),
      (FontAwesomeIcons.whatsapp.data, SiteLinks.whatsApp, 'WhatsApp'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          header: true,
          headingLevel: 1,
          label: 'Abdallah Ali Rehab, Senior Mobile Engineer',
          excludeSemantics: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _line('Abdallah', style, step(0.04, 0.52)),
              _line('Ali Rehab,', style, step(0.10, 0.58)),
              _line('Senior Mobile', style, step(0.16, 0.64)),
              _line(
                'Engineer.',
                style.copyWith(color: p.accentInk),
                step(0.22, 0.70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        _fadeUp(
          step(0.35, 0.8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 470),
            child: Text(
              '6+ years building Flutter apps for Android & iOS that serve '
              'millions of users — from architecture and performance to '
              'application security and delivery.',
              style: AppType.lead(context),
            ),
          ),
        ),
        const SizedBox(height: 36),
        _fadeUp(
          step(0.42, 0.87),
          Wrap(
            spacing: Space.gap,
            runSpacing: Space.gap,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PillButton(
                label: 'Download CV',
                icon: Icons.download_rounded,
                onPressed: () => launchUrl(
                  SiteLinks.cv,
                  mode: LaunchMode.externalApplication,
                ),
              ),
              PillButton(
                label: 'View work',
                variant: PillVariant.outline,
                onPressed: onViewWork,
              ),
              ArrowCircleButton(
                onPressed: onContact,
                semanticLabel: 'Get in touch',
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        _fadeUp(
          step(0.5, 0.95),
          Wrap(
            spacing: 8,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final (icon, url, label) in socials)
                CircleIconButton(
                  icon: icon,
                  semanticLabel: label,
                  onPressed: () => Pressable.open(url),
                ),
              const SizedBox(width: 10),
              InlineLink(
                label: SiteLinks.email,
                style: AppType.ui(context).copyWith(color: p.inkMuted),
                onTap: () =>
                    launchUrl(Uri(scheme: 'mailto', path: SiteLinks.email)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 4:5 portrait with a bottom scrim, a live "now" caption and a slight
/// pointer parallax on the photo inside its frame.
class _Portrait extends StatefulWidget {
  /// Intro progress: the photo settles from a 1.06 scale to rest.
  final double settle;

  const _Portrait({required this.settle});

  @override
  State<_Portrait> createState() => _PortraitState();
}

class _PortraitState extends State<_Portrait> {
  Offset _pointer = Offset.zero;

  void _track(PointerEvent e, Size size) {
    final dx = (e.localPosition.dx / size.width) * 2 - 1;
    final dy = (e.localPosition.dy / size.height) * 2 - 1;
    setState(() => _pointer = Offset(dx.clamp(-1, 1), dy.clamp(-1, 1)));
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final reduce = MediaQuery.of(context).disableAnimations;

    return Semantics(
      image: true,
      label: 'Portrait of Abdallah Ali Rehab',
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: LayoutBuilder(
          builder: (context, c) => MouseRegion(
            onHover: reduce ? null : (e) => _track(e, c.biggest),
            onExit: (_) => setState(() => _pointer = Offset.zero),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Space.radius),
                border: Border.all(color: p.line),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Space.radius - 1),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    TweenAnimationBuilder<Offset>(
                      tween: Tween(end: _pointer),
                      duration: const Duration(milliseconds: 700),
                      curve: Space.expo,
                      builder: (context, o, child) => Transform.translate(
                        offset: Offset(-o.dx * 8, -o.dy * 8),
                        child: Transform.scale(
                          scale: 1.04 + 0.06 * (1 - widget.settle),
                          child: child,
                        ),
                      ),
                      // Studio shot on white: a multiply grade pulls the
                      // white backdrop down to a moss-tinted bone so the
                      // photo sits in the palette instead of glaring.
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Palette.photoGrade,
                          BlendMode.multiply,
                        ),
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, -0.3),
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                    // Bottom scrim so the caption reads over the photo.
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0, 0.45],
                          colors: [
                            Palette.dark.ground.withValues(alpha: 0.85),
                            Palette.dark.ground.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: _PortraitCaption(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PortraitCaption extends StatelessWidget {
  const _PortraitCaption();

  @override
  Widget build(BuildContext context) {
    // The caption always sits on the dark scrim, so it uses the dark
    // palette in both themes.
    const d = Palette.dark;
    final style = AppType.caption(context).copyWith(color: d.ink);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 16,
              child: Center(child: InViewport(child: LiveDot())),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Now · Senior Mobile Engineer at MEGAMIND IT Solutions',
                style: style,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 16, color: d.accent),
            const SizedBox(width: 8),
            Text('Cairo, Egypt', style: style.copyWith(color: d.inkMuted)),
          ],
        ),
      ],
    );
  }
}

/// An 8px lime dot with a ring that expands and fades on a loop. Static
/// under reduced motion.
class LiveDot extends StatefulWidget {
  final double size;

  const LiveDot({super.key, this.size = 8});

  @override
  State<LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<LiveDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Palette.dark.accent;
    final s = widget.size;
    return SizedBox(
      width: s,
      height: s,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final t = Space.easeOut.transform(_c.value);
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + 1.6 * t,
                child: Container(
                  width: s,
                  height: s,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.6 * (1 - t)),
                  ),
                ),
              ),
              Container(
                width: s,
                height: s,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Hairline-topped line of where the work happens, separated by small lime
/// dots. Deliberately quiet: context, not a stat strip.
class _Ledger extends StatelessWidget {
  const _Ledger();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final base = AppType.caption(context).copyWith(fontSize: 14);
    final strong = base.copyWith(color: p.ink);
    final items = <(String, String)>[
      ('Currently — ', 'MEGAMIND IT Solutions, Cairo'),
      ('Previously — ', 'WalaPlus, Riyadh'),
      ('', 'WEDDnGO, Cairo'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: p.lineFaint)),
      ),
      child: Wrap(
        spacing: 14,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: p.signal,
                ),
              ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: items[i].$1, style: base),
                  TextSpan(text: items[i].$2, style: strong),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
