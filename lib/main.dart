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
import 'features/home/widgets/starfield_background.dart';
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
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  int _activeSection = 0;
  bool _showScrollToTop = false;
  bool _isNavCompact = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Show/hide scroll to top button
    if (_scrollController.offset > 200 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 200 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }

    // Compact the navbar once the user has scrolled past the hero.
    if (_scrollController.offset > 24 && !_isNavCompact) {
      setState(() => _isNavCompact = true);
    } else if (_scrollController.offset <= 24 && _isNavCompact) {
      setState(() => _isNavCompact = false);
    }

    // Track active section
    _updateActiveSection();
  }

  void _updateActiveSection() {
    final keys = [
      _homeKey,
      _aboutKey,
      _experienceKey,
      _skillsKey,
      _projectsKey,
      _contactKey,
    ];

    for (int i = 0; i < keys.length; i++) {
      final context = keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 100 && position.dy >= -box.size.height + 100) {
            if (_activeSection != i) {
              setState(() => _activeSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final keys = [
      _homeKey,
      _aboutKey,
      _experienceKey,
      _skillsKey,
      _projectsKey,
      _contactKey,
    ];

    if (index < keys.length) {
      Scrollable.ensureVisible(
        keys[index].currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToContact() {
    _scrollToSection(5); // Contact is the last nav index
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
          const StarfieldBackground(),
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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      HeroSection(
                        key: _homeKey,
                        onContactPressed: _scrollToContact,
                      ),
                      const ImpactSection(),
                      AboutSection(key: _aboutKey),
                      TimelineSection(key: _experienceKey),
                      const AiAssistedSection(),
                      TechStackSection(key: _skillsKey),
                      ProjectsSection(key: _projectsKey),
                      ContactSection(key: _contactKey),
                      const Footer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
