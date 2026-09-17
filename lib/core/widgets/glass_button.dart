import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;

  const GlassButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final onSurface = AppTheme.textColor(context);
    final foreground = widget.isPrimary ? accent : onSurface;

    return Semantics(
      button: true,
      label: widget.text,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedScale(
          scale: _hovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: accent.withValues(
                          alpha: widget.isPrimary ? 0.35 : 0.15,
                        ),
                        blurRadius: 24,
                        spreadRadius: 1,
                      ),
                    ]
                  : const [],
            ),
            child: Material(
              color: widget.isPrimary
                  ? accent.withValues(alpha: 0.1)
                  : onSurface.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(30),
                focusColor: accent.withValues(alpha: 0.18),
                hoverColor: accent.withValues(alpha: 0.12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: widget.isPrimary
                          ? accent.withValues(alpha: _hovered ? 0.9 : 0.5)
                          : onSurface.withValues(alpha: _hovered ? 0.35 : 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, color: foreground, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: foreground,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
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
