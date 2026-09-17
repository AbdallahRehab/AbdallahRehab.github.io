import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

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
    _SkillCategory(
      icon: Icons.auto_awesome_rounded,
      title: 'AI-Assisted Engineering',
      skills: [
        'AI-Assisted Coding & Debugging',
        'AI-Assisted Refactoring',
        'Architecture Brainstorming',
        'Automated Test & Doc Generation',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Text(
            'Skills',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textColor(context),
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 900
                    ? 3
                    : constraints.maxWidth > 560
                    ? 2
                    : 1;
                final itemWidth =
                    (constraints.maxWidth - (columns - 1) * 20) / columns;

                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (int i = 0; i < _categories.length; i++)
                      SizedBox(
                        width: itemWidth,
                        child: _CategoryCard(category: _categories[i])
                            .animate()
                            .fadeIn(delay: (100 + i * 60).ms)
                            .slideY(begin: 0.12, end: 0),
                      ),
                  ],
                );
              },
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

class _CategoryCard extends StatefulWidget {
  final _SkillCategory category;

  const _CategoryCard({required this.category});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final category = widget.category;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0.0, 1.0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardColor(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? accent.withValues(alpha: 0.5)
                : AppTheme.borderColor(context),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(category.icon, color: accent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category.title,
                    style: TextStyle(
                      color: AppTheme.textColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.skills
                  .map(
                    (s) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.borderColor(
                          context,
                        ).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        s,
                        style: TextStyle(
                          color: AppTheme.textColorSecondary(context),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
