import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import 'widgets/project_card.dart';
import 'widgets/project_details_modal.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  List<dynamic> _projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = json.decode(response);
    setState(() {
      _projects = data['projects'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textColor(context),
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),

          const SizedBox(height: 12),

          Text(
            'Real products, real constraints — tap a card for the full case study.',
            style: TextStyle(color: AppTheme.textColorSecondary(context)),
          ).animate().fadeIn(delay: 100.ms),

          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {
              // Cards size to their own content (natural height) rather than
              // a fixed aspect ratio, so a project with more impact/tech
              // chips never overflows a hard-coded card height.
              final columns = constraints.maxWidth > 1100
                  ? 3
                  : constraints.maxWidth > 700
                  ? 2
                  : 1;
              final itemWidth =
                  (constraints.maxWidth - (columns - 1) * 24) / columns;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  for (int i = 0; i < _projects.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: ProjectCard(
                        project: _projects[i],
                        animationDelay: Duration(milliseconds: i * 80),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                ProjectDetailsModal(project: _projects[i]),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
