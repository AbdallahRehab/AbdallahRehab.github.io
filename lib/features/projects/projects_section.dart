import 'package:flutter/material.dart';

import '../../core/portfolio_data.dart';
import '../../core/theme/app_theme.dart';
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
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final projects = await PortfolioData.projects();
      if (mounted) setState(() => _projects = projects);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
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
          if (_failed)
            Text(
              "The case studies couldn't load. Refresh the page, or ask for "
              'them by email — the CV covers each one.',
              style: AppType.body(context),
            ),
          ResponsiveGrid(
            columnsFor: (w) => w > 760 ? 2 : 1,
            equalHeight: true,
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
