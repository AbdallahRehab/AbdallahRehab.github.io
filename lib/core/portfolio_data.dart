import 'dart:convert';

import 'package:flutter/services.dart';

/// Case-study data from assets/config.json, loaded and decoded once and
/// shared by every section that reads it.
class PortfolioData {
  PortfolioData._();

  static Future<List<Map<String, dynamic>>>? _projects;

  static Future<List<Map<String, dynamic>>> projects() =>
      _projects ??= rootBundle.loadString('assets/config.json').then((raw) {
        final data = json.decode(raw) as Map<String, dynamic>;
        return (data['projects'] as List<dynamic>).cast<Map<String, dynamic>>();
      });
}
