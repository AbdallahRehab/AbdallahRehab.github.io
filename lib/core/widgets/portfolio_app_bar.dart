import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/app_theme.dart';

class PortfolioAppBar extends StatefulWidget {
  final Function(int) onNavigate;
  final int activeIndex;
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const PortfolioAppBar({
    super.key,
    required this.onNavigate,
    required this.activeIndex,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<PortfolioAppBar> createState() => _PortfolioAppBarState();
}

class _PortfolioAppBarState extends State<PortfolioAppBar> {
  static const List<String> _navItems = [
    'Home',
    'About',
    'Experience',
    'Skills',
    'Projects',
    'Contact',
  ];

  bool _mobileMenuOpen = false;

  void _navigate(int index) {
    setState(() => _mobileMenuOpen = false);
    widget.onNavigate(index);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor(context).withValues(alpha: 0.95),
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.primaryColor(context).withValues(alpha: 0.2),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: widget.isDarkMode ? 0.3 : 0.1,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isWide
                  ? _buildDesktopRow(context)
                  : _buildMobileRow(context),
            ),
          ),
          if (!isWide && _mobileMenuOpen) _buildMobileMenu(context),
        ],
      ),
    );
  }

  Widget _buildDesktopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...List.generate(
          _navItems.length,
          (index) => _NavLink(
            label: _navItems[index],
            isActive: widget.activeIndex == index,
            onTap: () => _navigate(index),
          ),
        ),
        const SizedBox(width: 8),
        _ThemeToggle(
          isDarkMode: widget.isDarkMode,
          onPressed: widget.onThemeToggle,
        ),
      ],
    );
  }

  Widget _buildMobileRow(BuildContext context) {
    final textColor = AppTheme.textColor(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Semantics(
          button: true,
          label: _mobileMenuOpen
              ? 'Close navigation menu'
              : 'Open navigation menu',
          child: IconButton(
            onPressed: () => setState(() => _mobileMenuOpen = !_mobileMenuOpen),
            icon: Icon(
              _mobileMenuOpen ? Icons.close : Icons.menu_rounded,
              color: textColor,
            ),
          ),
        ),
        _ThemeToggle(
          isDarkMode: widget.isDarkMode,
          onPressed: widget.onThemeToggle,
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.surfaceColor(context).withValues(alpha: 0.98),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(_navItems.length, (index) {
          final isActive = widget.activeIndex == index;
          return Semantics(
            button: true,
            label: _navItems[index],
            child: InkWell(
              onTap: () => _navigate(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Text(
                  _navItems[index],
                  style: TextStyle(
                    color: isActive
                        ? AppTheme.primaryColor(context)
                        : AppTheme.textColor(context),
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final secondaryAccent = AppTheme.secondaryColor(context);
    final baseColor = AppTheme.textColorSecondary(context);

    final color = widget.isActive
        ? accent
        : _isHovered
        ? secondaryAccent
        : baseColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Semantics(
        button: true,
        label: widget.label,
        child: InkWell(
          onTap: widget.onTap,
          focusColor: accent.withValues(alpha: 0.1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            transform: Matrix4.identity()
              ..translateByDouble(0.0, _isHovered ? -1.0 : 0.0, 0.0, 1.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.isActive
                      ? accent
                      : (_isHovered
                            ? color.withValues(alpha: 0.4)
                            : Colors.transparent),
                  width: 2,
                ),
              ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(widget.label),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onPressed;

  const _ThemeToggle({required this.isDarkMode, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        color: AppTheme.primaryColor(context),
      ),
      tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
    );
  }
}
