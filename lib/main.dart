import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/footer.dart';
import 'core/widgets/portfolio_app_bar.dart';
import 'core/widgets/responsive_layout.dart';
import 'core/widgets/scroll_to_top_button.dart';
import 'features/about/about_section.dart';
import 'features/about/timeline_section.dart';
import 'features/contact/contact_section.dart';
import 'features/home/widgets/ai_assisted_section.dart';
import 'features/home/widgets/hero_section.dart';
import 'features/home/widgets/tech_stack_section.dart';
import 'features/impact/impact_section.dart';
import 'features/projects/projects_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? true;
  runApp(
    PortfolioApp(initialThemeMode: isDark ? ThemeMode.dark : ThemeMode.light),
  );
}

class PortfolioApp extends StatefulWidget {
  final ThemeMode initialThemeMode;

  const PortfolioApp({super.key, required this.initialThemeMode});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _toggleTheme() async {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdallah Ali Rehab | Senior Mobile Engineer, Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      builder: (context, child) => ResponsiveLayout(child: child!),
      home: HomePage(onThemeToggle: _toggleTheme, themeMode: _themeMode),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  /// Section anchors in page order: hero, about, scale, experience, work,
  /// skills, contact. Indexes match [PortfolioAppBar.navItems].
  final List<GlobalKey> _keys = List.generate(7, (_) => GlobalKey());

  int _activeSection = 0;
  bool _showScrollToTop = false;
  bool _isNavCompact = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    // Shown once past the hero, hidden again at the footer, which has its
    // own back-to-top control.
    final showTop =
        offset > 600 && _scrollController.position.extentAfter > 240;
    final compact = offset > 24;
    if (showTop != _showScrollToTop || compact != _isNavCompact) {
      setState(() {
        _showScrollToTop = showTop;
        _isNavCompact = compact;
      });
    }
    _updateActiveSection();
  }

  void _updateActiveSection() {
    // The last section whose top has passed a line a third of the way down
    // the viewport is the one being read.
    final line = MediaQuery.sizeOf(context).height / 3;
    var active = 0;
    for (var i = 0; i < _keys.length; i++) {
      final box = _keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= line) active = i;
    }
    if (_scrollController.position.extentAfter < 40) active = _keys.length - 1;
    if (active != _activeSection) setState(() => _activeSection = active);
  }

  void _scrollToSection(int index) {
    final target = _keys[index].currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 900),
      curve: Space.expo,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 900),
      curve: Space.expo,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PortfolioAppBar(
                onNavigate: _scrollToSection,
                activeIndex: _activeSection,
                onThemeToggle: widget.onThemeToggle,
                isDarkMode: widget.themeMode == ThemeMode.dark,
                isScrolled: _isNavCompact,
              ),
              Expanded(
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeroSection(
                          key: _keys[0],
                          onViewWork: () => _scrollToSection(4),
                          onContact: () =>
                              _scrollToSection(PortfolioAppBar.contactIndex),
                        ),
                        AboutSection(key: _keys[1]),
                        ImpactSection(key: _keys[2]),
                        TimelineSection(key: _keys[3]),
                        ProjectsSection(key: _keys[4]),
                        TechStackSection(key: _keys[5]),
                        const AiAssistedSection(),
                        ContactSection(key: _keys[6]),
                        Footer(onBackToTop: _scrollToTop),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Desktop only: on phones the disc would sit over body copy, and
          // the monogram and footer already return to the top.
          if (MediaQuery.sizeOf(context).width > 700)
            Positioned(
              right: 24,
              bottom: 24,
              child: ScrollToTopButton(
                onPressed: _scrollToTop,
                isVisible: _showScrollToTop,
              ),
            ),
        ],
      ),
    );
  }
}
