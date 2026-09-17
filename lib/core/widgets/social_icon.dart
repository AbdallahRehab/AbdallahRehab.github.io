import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool _hovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = AppTheme.textColor(context);
    final accent = AppTheme.secondaryColor(context);
    final iconColor = _hovered ? accent : onSurface;

    return Tooltip(
      message: widget.label,
      child: Semantics(
        button: true,
        label: 'Open ${widget.label}',
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedScale(
            scale: _hovered ? 1.12 : 1.0,
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            child: Material(
              color: onSurface.withValues(alpha: 0.05),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: _launchUrl,
                customBorder: const CircleBorder(),
                focusColor: accent.withValues(alpha: 0.2),
                hoverColor: accent.withValues(alpha: 0.12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _hovered
                          ? accent.withValues(alpha: 0.7)
                          : onSurface.withValues(alpha: 0.2),
                    ),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: accent.withValues(alpha: 0.25),
                              blurRadius: 16,
                              spreadRadius: 1,
                            ),
                          ]
                        : const [],
                  ),
                  child: FaIcon(widget.icon, color: iconColor, size: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
