import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  static const _categories = [
    _SkillCategory(
      icon: Icons.smartphone_rounded,
      title: 'Mobile Development',
      skills: ['Flutter', 'Dart', 'Kotlin', 'Swift', 'Android', 'iOS'],
    ),
    _SkillCategory(
      icon: Icons.architecture_rounded,
      title: 'Architecture & State',
      skills: [
        'Clean Architecture',
        'Modular Architecture',
        'Bloc',
        'Provider',
        'Riverpod',
        'GetX',
      ],
    ),
    _SkillCategory(
      icon: Icons.dns_outlined,
      title: 'Backend & APIs',
      skills: ['REST APIs', 'GraphQL', 'OAuth', 'JWT', 'Firebase Auth'],
    ),
    _SkillCategory(
      icon: Icons.storage_rounded,
      title: 'Data & Storage',
      skills: ['Hive', 'SQLite', 'ObjectBox', 'Shared Preferences'],
    ),
    _SkillCategory(
      icon: Icons.insights_rounded,
      title: 'Integrations & Analytics',
      skills: [
        'Firebase',
        'CleverTap',
        'Sentry',
        'Intercom',
        'Smartlook',
        'Braintree',
        'Paymob',
        'Stripe',
        'PayPal',
      ],
    ),
    _SkillCategory(
      icon: Icons.build_circle_outlined,
      title: 'DevOps & Delivery',
      skills: [
        'CI/CD',
        'GitHub Actions',
        'Bitrise',
        'Codemagic',
        'App Store & Play Store Release Mgmt',
      ],
    ),
    _SkillCategory(
      icon: Icons.security_rounded,
      title: 'Application Security',
      skills: [
        'Secure Storage',
        'Threat Modeling',
        'Reverse-Engineering Protection',
        'MiTM Protection',
        'Encrypted Communication',
      ],
    ),
    _SkillCategory(
      icon: Icons.speed_rounded,
      title: 'Performance & Testing',
      skills: [
        'Profiling',
        'Isolates',
        'Async/Await',
        'Unit/Widget/Integration Tests',
        'Mocktail',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Section(
      constrain: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PageColumn(
            child: SectionHeader(
              title: 'The toolbox',
              lead:
                  'What I reach for across mobile, architecture, delivery and '
                  'security.',
            ),
          ),
          const Reveal(child: _Marquee()),
          SizedBox(height: AppType.fluid(context, 40, 72)),
          PageColumn(
            child: ResponsiveGrid(
              gap: AppType.fluid(context, 24, 48),
              runGap: 0,
              columnsFor: (w) => w > 860 ? 2 : 1,
              children: [for (final c in _categories) _SkillRow(category: c)],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCategory {
  final IconData icon;
  final String title;
  final List<String> skills;

  const _SkillCategory({
    required this.icon,
    required this.title,
    required this.skills,
  });
}

class _SkillRow extends StatelessWidget {
  final _SkillCategory category;

  const _SkillRow({required this.category});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Reveal(
      child: HoverRegion(
        builder: (context, hovered) => AnimatedContainer(
          duration: Space.slow,
          curve: Space.expo,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: p.line)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      category.title,
                      style: AppType.ui(context, size: 16).copyWith(
                        fontWeight: FontWeight.w600,
                        color: hovered ? p.accentInk : p.ink,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      category.skills.join('  ·  '),
                      style: AppType.body(context, size: 14.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Full-bleed band of core technologies drifting left on a loop, edges
/// faded out, paused on hover. Static and centred under reduced motion.
class _Marquee extends StatefulWidget {
  const _Marquee();

  static final _items = <(IconData?, String)>[
    (FontAwesomeIcons.flutter.data, 'Flutter'),
    (null, 'Dart'),
    (FontAwesomeIcons.android.data, 'Android'),
    (FontAwesomeIcons.apple.data, 'iOS'),
    (null, 'Kotlin'),
    (FontAwesomeIcons.swift.data, 'Swift'),
    (null, 'Firebase'),
    (null, 'Riverpod'),
    (null, 'Bloc'),
    (null, 'GraphQL'),
    (FontAwesomeIcons.github.data, 'GitHub Actions'),
    (null, 'Codemagic'),
    (null, 'Sentry'),
    (FontAwesomeIcons.stripe.data, 'Stripe'),
  ];

  @override
  State<_Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<_Marquee>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 48),
  );
  final _measureKey = GlobalKey();
  double _runWidth = 0;
  bool _reduce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduce = MediaQuery.of(context).disableAnimations;
    if (_reduce) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final box = _measureKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize && box.size.width != _runWidth) {
      setState(() => _runWidth = box.size.width);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _run(BuildContext context, {Key? key}) {
    final p = context.palette;
    final style = AppType.h3(context, size: AppType.fluid(context, 18, 22));
    return Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (icon, label) in _Marquee._items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 30),
                if (icon != null) ...[
                  Icon(icon, size: 22, color: p.ink.withValues(alpha: 0.85)),
                  const SizedBox(width: 12),
                ],
                Text(label, style: style),
                const SizedBox(width: 30),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.signal,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final band = BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(color: p.line)),
    );

    if (_reduce) {
      return Container(
        decoration: band,
        child: PageColumn(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [_run(context)],
          ),
        ),
      );
    }

    return Semantics(
      label:
          'Core technologies: ${_Marquee._items.map((e) => e.$2).join(', ')}',
      excludeSemantics: true,
      child: MouseRegion(
        onEnter: (_) => _c.stop(),
        onExit: (_) => _c.repeat(),
        child: Container(
          decoration: band,
          child: ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              colors: [
                Color(0x00000000),
                Color(0xFF000000),
                Color(0xFF000000),
                Color(0x00000000),
              ],
              stops: [0, 0.08, 0.92, 1],
            ).createShader(rect),
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 74,
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: _c,
                  builder: (context, child) => Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(
                        left: -_runWidth * _c.value,
                        top: 0,
                        bottom: 0,
                        child: child!,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _run(context, key: _measureKey),
                      _run(context),
                      _run(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
