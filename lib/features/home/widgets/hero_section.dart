import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/animated_metric.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/social_icon.dart';
import 'hero_orbit_background.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onContactPressed;

  const HeroSection({super.key, this.onContactPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  static const _metrics = [
    _Metric('6+', 'Years Experience'),
    _Metric('7M+', 'Combined Users'),
    _Metric('60%', 'Faster Load Times'),
    _Metric('90%', 'Test Coverage'),
  ];

  // Shared cursor signal for the whole scene — the orbit ring/glow behind
  // the copy and the avatar in front of it react to the same position at
  // different strengths, so the hero reads as layered depth rather than
  // one widget independently tilting.
  Offset _scenePointer = Offset.zero;

  void _updateScenePointer(PointerEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final local = box.globalToLocal(event.position);
    final dx = ((local.dx / box.size.width) * 2 - 1).clamp(-1.0, 1.0);
    final dy = ((local.dy / box.size.height) * 2 - 1).clamp(-1.0, 1.0);
    setState(() => _scenePointer = Offset(dx, dy));
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);

    return MouseRegion(
      onHover: _updateScenePointer,
      onExit: (_) => setState(() => _scenePointer = Offset.zero),
      child: Container(
      constraints: const BoxConstraints(minHeight: 760),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: HeroOrbitBackground(pointer: _scenePointer)),
          Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar — tilts toward the cursor, like a subtle 3D card,
              // and drifts a couple of px with the wider scene as a
              // foreground parallax layer.
              _TiltAvatar(ambientParallax: _scenePointer)
                  .animate()
                  .fadeIn(duration: 700.ms)
                  .scale(
                    begin: const Offset(0.55, 0.55),
                    end: const Offset(1, 1),
                    duration: 900.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 28),

              // Eyebrow badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accent.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'FLUTTER · ANDROID & iOS SPECIALIST',
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.4,
                  ),
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 20),

              // Name
              Text(
                'Abdallah Ali Rehab',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 12),

              // Role
              Text(
                'Senior Mobile Engineer · Flutter',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 20),

              // Positioning statement
              Text(
                '6+ years building Flutter apps for Android & iOS that serve '
                'millions of users — from architecture and performance to '
                'application security and delivery.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 48),

              // Metrics strip — each tile pops in individually with a
              // slight bounce, staggered left to right.
              Wrap(
                spacing: 36,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < _metrics.length; i++)
                    AnimatedMetric(
                          value: _metrics[i].value,
                          label: _metrics[i].label,
                          valueColor: textColor,
                          labelColor: textSecondary,
                        )
                        .animate()
                        .fadeIn(
                          delay: (350 + i * 90).ms,
                          duration: 450.ms,
                        )
                        .scale(
                          delay: (350 + i * 90).ms,
                          duration: 450.ms,
                          begin: const Offset(0.7, 0.7),
                          end: const Offset(1, 1),
                          curve: Curves.easeOutBack,
                        ),
                ],
              ),

              const SizedBox(height: 48),

              // CTAs
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  GlassButton(
                    text: 'Download CV',
                    icon: Icons.download_rounded,
                    onPressed: () {
                      // Served as a static file at the site root (web/cv.pdf),
                      // resolved against the current origin so it works both
                      // in local dev and on the deployed domain.
                      launchUrl(
                        Uri.base.resolve('cv.pdf'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  GlassButton(
                    text: 'Contact Me',
                    icon: Icons.mail_outline_rounded,
                    isPrimary: false,
                    onPressed: () => widget.onContactPressed?.call(),
                  ),
                ],
              ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 48),

              // Socials
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: const [
                  SocialIcon(
                    icon: FontAwesomeIcons.linkedinIn,
                    url:
                        'https://www.linkedin.com/in/abdallah-ali-rehab-a71246153',
                    label: 'LinkedIn',
                  ),
                  SocialIcon(
                    icon: FontAwesomeIcons.github,
                    url: 'https://github.com/AbdallahRehab',
                    label: 'GitHub',
                  ),
                  SocialIcon(
                    icon: FontAwesomeIcons.xTwitter,
                    url: 'https://x.com/abdallahrehab2',
                    label: 'X (Twitter)',
                  ),
                  SocialIcon(
                    icon: FontAwesomeIcons.whatsapp,
                    url: 'https://wa.me/2001559292997',
                    label: 'WhatsApp',
                  ),
                ],
              ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
        ],
      ),
      ),
    );
  }
}

class _Metric {
  final String value;
  final String label;
  const _Metric(this.value, this.label);
}

/// A small pointer-tracking 3D tilt on the avatar — desktop mice/trackpads
/// get a responsive parallax; touch devices simply see the resting pose,
/// since there's no hover signal to tilt from. [ambientParallax] additionally
/// drifts the whole avatar a few px with the cursor even when it isn't the
/// thing being hovered — the "foreground" layer of the hero's parallax.
class _TiltAvatar extends StatefulWidget {
  final Offset ambientParallax;

  const _TiltAvatar({this.ambientParallax = Offset.zero});

  @override
  State<_TiltAvatar> createState() => _TiltAvatarState();
}

class _TiltAvatarState extends State<_TiltAvatar> {
  Offset _target = Offset.zero;
  bool _hovering = false;

  void _updateTilt(PointerEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final local = box.globalToLocal(event.position);
    final dx = ((local.dx / box.size.width) * 2 - 1).clamp(-1.0, 1.0);
    final dy = ((local.dy / box.size.height) * 2 - 1).clamp(-1.0, 1.0);
    setState(() => _target = Offset(dx, dy));
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);

    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: Offset.zero, end: widget.ambientParallax),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      builder: (context, ambient, child) {
        return Transform.translate(
          offset: Offset(ambient.dx * 14, ambient.dy * 14),
          child: child,
        );
      },
      child: MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onHover: _updateTilt,
      onExit: (_) => setState(() {
        _hovering = false;
        _target = Offset.zero;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: _hovering ? 0.4 : 0.25),
              blurRadius: _hovering ? 40 : 28,
              spreadRadius: _hovering ? 4 : 2,
            ),
          ],
        ),
        child: TweenAnimationBuilder<Offset>(
          tween: Tween(begin: Offset.zero, end: _target),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateX(-value.dy * 0.35)
                ..rotateY(value.dx * 0.35)
                ..scaleByDouble(
                  _hovering ? 1.05 : 1.0,
                  _hovering ? 1.05 : 1.0,
                  1.0,
                  1.0,
                ),
              child: child,
            );
          },
          child: Semantics(
            image: true,
            label: 'Portrait photo of Abdallah Ali Rehab',
            child: Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: accent.withValues(alpha: 0.5),
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/avatar.jpg'),
                  fit: BoxFit.cover,
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
