import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/animated_metric.dart';

/// A single interactive "engineering impact" dashboard: the headline numbers
/// up top, then a small system diagram connecting one shared mobile
/// engineering practice to the three flagship products it has been applied
/// to, each expandable on hover/tap for the CV-backed specifics.
class ImpactSection extends StatelessWidget {
  const ImpactSection({super.key});

  static const _headline = [
    _Metric('7M+', 'Combined Active Users'),
    _Metric('60%', 'Faster Load Times'),
    _Metric('90%', 'Test Coverage'),
    _Metric('70%', 'Fewer Bug Reports'),
  ];

  static const _products = [
    _Product(
      name: 'Saudi German Health',
      users: '3.5M+',
      domain: 'Healthcare',
      platform: 'iOS · Android',
      contribution:
          'Leading Flutter development — modernized a legacy codebase and '
          'hardened it to healthcare-grade security standards.',
    ),
    _Product(
      name: 'WalaOne',
      users: '3M+',
      domain: 'Loyalty & Rewards',
      platform: 'iOS · Android',
      contribution:
          'Owned performance and architecture — caching, modular refactor, '
          'and unit test coverage up to 90%.',
    ),
    _Product(
      name: 'Doam',
      users: '1.2M+',
      domain: 'Public-Sector Rewards',
      platform: 'iOS · Android',
      contribution:
          'Initiated from zero — architecture, CI/CD pipelines, and coding '
          'standards for a government partnership.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Text(
                'Engineering Impact',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: 12),

              Text(
                'The same engineering practice, applied across products used by millions.',
                style: TextStyle(color: textSecondary),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 48),

              // Headline numbers.
              Wrap(
                spacing: 48,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: _headline
                    .map(
                      (m) => AnimatedMetric(
                        value: m.value,
                        label: m.label,
                        valueColor: textColor,
                        labelColor: textSecondary,
                        valueSize: 30,
                        labelSize: 13,
                      ),
                    )
                    .toList(),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15, end: 0),

              const SizedBox(height: 64),

              // Product breakdown.
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 860
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
                      for (int i = 0; i < _products.length; i++)
                        SizedBox(
                          width: itemWidth,
                          child: _ProductNodeCard(product: _products[i])
                              .animate()
                              .fadeIn(delay: (300 + i * 100).ms)
                              .slideY(begin: 0.15, end: 0),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
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

class _Product {
  final String name;
  final String users;
  final String domain;
  final String platform;
  final String contribution;

  const _Product({
    required this.name,
    required this.users,
    required this.domain,
    required this.platform,
    required this.contribution,
  });
}

class _ProductNodeCard extends StatefulWidget {
  final _Product product;

  const _ProductNodeCard({required this.product});

  @override
  State<_ProductNodeCard> createState() => _ProductNodeCardState();
}

class _ProductNodeCardState extends State<_ProductNodeCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.primaryColor(context);
    final textColor = AppTheme.textColor(context);
    final textSecondary = AppTheme.textColorSecondary(context);
    final product = widget.product;

    return MouseRegion(
      onEnter: (_) => setState(() => _expanded = true),
      onExit: (_) => setState(() => _expanded = false),
      child: GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Semantics(
          button: true,
          label: '${product.name}, ${product.users} users. ${product.contribution}',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.cardColor(context),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _expanded
                    ? accent.withValues(alpha: 0.5)
                    : AppTheme.borderColor(context),
              ),
              boxShadow: _expanded
                  ? [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.15),
                        blurRadius: 24,
                        spreadRadius: 1,
                      ),
                    ]
                  : const [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      product.domain,
                      style: TextStyle(
                        color: accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  product.users,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.platform,
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  child: _expanded
                      ? Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(
                            product.contribution,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
