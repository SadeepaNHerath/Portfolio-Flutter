import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentWorkSection extends StatefulWidget {
  const RecentWorkSection({super.key});

  @override
  State<RecentWorkSection> createState() => _RecentWorkSectionState();
}

class _RecentWorkSectionState extends State<RecentWorkSection> {
  static const List<String> _filters = ['All', 'Web', 'AI', 'Mobile'];
  String _selectedFilter = 'All';

  final List<Map<String, String>> projectDetails = [
    {
      'title': 'Tic-Tac-Toe',
      'description': 'A responsive game with player-vs-player and player-vs-computer modes using JavaScript, HTML, CSS, and Bootstrap.',
      'url': 'https://github.com/SadeepaNHerath/Tic-Tac-Toe',
      'category': 'Web',
      'image': 'assets/work_0.jpg',
    },
    {
      'title': 'MetaScribe',
      'description': 'An AI-oriented project focused on productivity and content workflows, built with practical full-stack patterns.',
      'url': 'https://github.com/SadeepaNHerath/MetaScribe',
      'category': 'AI',
      'image': 'assets/work_1.jpg',
    },
    {
      'title': 'Mazex Website',
      'description': 'Continuous UI and feature improvements delivered through pull requests, form enhancements, and admin-focused updates.',
      'url': 'https://github.com/SadeepaNHerath/mazex-website',
      'category': 'Web',
      'image': 'assets/work_2.jpg',
    },
    {
      'title': 'Open_Books',
      'description': 'A repository focused on book-related tooling and iterative improvements through regular commits.',
      'url': 'https://github.com/SadeepaNHerath/Open_Books',
      'category': 'Mobile',
      'image': 'assets/work_3.jpg',
    },
  ];

  List<Map<String, String>> get _filteredProjects {
    if (_selectedFilter == 'All') {
      return projectDetails;
    }
    return projectDetails
        .where((project) => project['category'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects = _filteredProjects;

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: _filters.map((filter) {
              final isSelected = _selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  selectedColor: Colors.teal,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: filteredProjects.isEmpty
              ? const Center(
                  child: Text(
                    'No projects found for this filter.',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = filteredProjects[index];
                    return GestureDetector(
                      onTap: () => _showProjectDetails(context, project),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(project['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              project['category']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showProjectDetails(BuildContext context, Map<String, String> project) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  project['image']!,
                  fit: BoxFit.fitWidth,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                project['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                project['description']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _openProjectLink(project['url']!),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open Repo'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Close"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openProjectLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}