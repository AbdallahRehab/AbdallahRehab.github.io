import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'buttons.dart';
import 'pressable.dart';

/// Site header: monogram, section links with a lime underline that draws in
/// from the left, theme toggle and a "Let's talk" pill. Transparent at the
/// top of the page; gains a hairline once the page scrolls. Collapses to a
/// menu button and a full-width link sheet on narrow screens.
class PortfolioAppBar extends StatefulWidget {
  final ValueChanged<int> onNavigate;
  final int activeIndex;
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  final bool isScrolled;

  const PortfolioAppBar({
    super.key,
    required this.onNavigate,
    required this.activeIndex,
    required this.onThemeToggle,
    required this.isDarkMode,
    this.isScrolled = false,
  });

  /// Section index each nav label scrolls to (0 is the hero).
  static const navItems = <(String, int)>[
    ('About', 1),
    ('Experience', 3),
    ('Work', 4),
    ('Skills', 5),
    ('Contact', 6),
  ];

  static const contactIndex = 6;

  @override
  State<PortfolioAppBar> createState() => _PortfolioAppBarState();
}

class _PortfolioAppBarState extends State<PortfolioAppBar> {
  bool _menuOpen = false;

  void _go(int index) {
    setState(() => _menuOpen = false);
    widget.onNavigate(index);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final wide = context.screenWidth > 860;
    final g = Space.gutter(context);

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Space.fast,
            curve: Space.easeOut,
            height: 72,
            decoration: BoxDecoration(
              color: p.ground,
              border: Border(
                bottom: BorderSide(
                  color: widget.isScrolled || _menuOpen
                      ? p.line
                      : Colors.transparent,
                ),
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Space.maxWidth + g * 2),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: g),
                  child: Row(
                    children: [
                      _Monogram(onTap: () => _go(0)),
                      const Spacer(),
                      if (wide) ...[
                        for (final (label, index) in PortfolioAppBar.navItems)
                          _NavLink(
                            label: label,
                            active: widget.activeIndex == index,
                            onTap: () => _go(index),
                          ),
                        const SizedBox(width: 16),
                      ],
                      CircleIconButton(
                        icon: widget.isDarkMode
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        semanticLabel: widget.isDarkMode
                            ? 'Switch to light mode'
                            : 'Switch to dark mode',
                        onPressed: widget.onThemeToggle,
                      ),
                      const SizedBox(width: 8),
                      PillButton(
                        label: "Let's talk",
                        compact: true,
                        onPressed: () => _go(PortfolioAppBar.contactIndex),
                      ),
                      if (!wide) ...[
                        const SizedBox(width: 8),
                        CircleIconButton(
                          icon: _menuOpen
                              ? Icons.close_rounded
                              : Icons.menu_rounded,
                          semanticLabel: _menuOpen
                              ? 'Close navigation menu'
                              : 'Open navigation menu',
                          onPressed: () =>
                              setState(() => _menuOpen = !_menuOpen),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (!wide)
            AnimatedSize(
              duration: Space.slow,
              curve: Space.expo,
              alignment: Alignment.topCenter,
              child: _menuOpen
                  ? _MobileMenu(activeIndex: widget.activeIndex, onTap: _go)
                  : const SizedBox(width: double.infinity),
            ),
        ],
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  final VoidCallback onTap;

  const _Monogram({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Pressable(
      onTap: onTap,
      semanticLabel: 'Abdallah Ali Rehab — back to top',
      builder: (context, active) => SizedBox.square(
        dimension: 44,
        child: Center(
          child: AnimatedContainer(
            duration: Space.fast,
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: active ? p.accentInk : p.line),
            ),
            child: Text(
              'AR',
              style: AppType.h3(
                context,
                size: 16,
              ).copyWith(color: active ? p.accentInk : p.ink, height: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Pressable(
      onTap: onTap,
      semanticLabel: label,
      focusRadius: 4,
      builder: (context, hovered) {
        final on = hovered || active;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: AnimatedDefaultTextStyle(
                  duration: Space.fast,
                  style: AppType.ui(
                    context,
                  ).copyWith(color: on ? p.ink : p.inkMuted),
                  child: Text(label),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedFractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  duration: Space.slow,
                  curve: Space.expo,
                  widthFactor: on ? 1 : 0,
                  child: Container(height: 1, color: p.accentInk),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _MobileMenu({required this.activeIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final g = Space.gutter(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: p.ground,
        border: Border(bottom: BorderSide(color: p.line)),
      ),
      padding: EdgeInsets.fromLTRB(g, 8, g, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (label, index) in PortfolioAppBar.navItems)
            Pressable(
              onTap: () => onTap(index),
              semanticLabel: label,
              focusRadius: 4,
              builder: (context, hovered) => Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: p.lineFaint)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: AppType.h3(context, size: 28).copyWith(
                          color: activeIndex == index || hovered
                              ? p.accentInk
                              : p.ink,
                        ),
                      ),
                    ),
                    ArrowCircle(
                      size: 32,
                      outlined: true,
                      active: activeIndex == index || hovered,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
