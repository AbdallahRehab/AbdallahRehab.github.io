import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/widgets/section.dart';
import 'widgets/project_card.dart';
import 'widgets/project_details_modal.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  List<Map<String, dynamic>> _projects = const [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final data = json.decode(await rootBundle.loadString('assets/config.json'));
    if (!mounted) return;
    setState(() {
      _projects = (data['projects'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
    });
  }

  void _open(Map<String, dynamic> project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => ProjectDetailsModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'Selected work',
            lead:
                'Real products, real constraints — open any one for the full '
                'case study.',
          ),
          ResponsiveGrid(
            columnsFor: (w) => w > 760 ? 2 : 1,
            children: [
              for (var i = 0; i < _projects.length; i++)
                ProjectCard(
                  project: _projects[i],
                  index: i,
                  onTap: () => _open(_projects[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
