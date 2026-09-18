import 'package:flutter/material.dart';

/// Small, deliberately simple helpers that turn the free-form `technologies`
/// list in assets/config.json into the engineering categories used in the
/// case-study modal, plus a per-project icon. Keyword-matched rather than a
/// new JSON schema field, since the existing tag lists already carry enough
/// signal for this.
class ProjectTaxonomy {
  ProjectTaxonomy._();

  static const _categoryKeywords = {
    'Architecture': ['architecture', 'dependency injection', 'clean'],
    'Performance': ['caching', 'profiling', 'async', 'isolate'],
    'Security': ['secure', 'encrypt', 'security', 'threat', 'mitm'],
    'Testing': ['test', 'mocktail'],
    'Delivery': ['ci/cd', 'github actions', 'bitrise', 'codemagic', 'release'],
  };

  /// Groups a project's technology tags under engineering category labels.
  /// Anything that doesn't match a known keyword falls under "Core Stack".
  static Map<String, List<String>> groupTechnologies(List<String> technologies) {
    final grouped = <String, List<String>>{};
    for (final tech in technologies) {
      final lower = tech.toLowerCase();
      final category = _categoryKeywords.entries
          .firstWhere(
            (entry) => entry.value.any((kw) => lower.contains(kw)),
            orElse: () => const MapEntry('Core Stack', <String>[]),
          )
          .key;
      grouped.putIfAbsent(category, () => []).add(tech);
    }
    return grouped;
  }

  static IconData iconFor(String projectName) {
    switch (projectName) {
      case 'Saudi German Health':
        return Icons.local_hospital_outlined;
      case 'PDentalCore':
        return Icons.medical_services_outlined;
      case 'WalaOne':
      case 'WalaPlus':
        return Icons.loyalty_outlined;
      case 'Doam':
        return Icons.workspace_premium_outlined;
      case 'WEDDnGO':
        return Icons.favorite_border_rounded;
      default:
        return Icons.apps_rounded;
    }
  }
}
