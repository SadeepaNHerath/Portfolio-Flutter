import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentWorkSection extends StatelessWidget {
  RecentWorkSection({super.key});

  final List<Map<String, String>> projectDetails = [
    {
      'title': 'Tic-Tac-Toe',
      'description': 'A responsive game with player-vs-player and player-vs-computer modes using JavaScript, HTML, CSS, and Bootstrap.',
      'url': 'https://github.com/SadeepaNHerath/Tic-Tac-Toe',
    },
    {
      'title': 'MetaScribe',
      'description': 'An AI-oriented project focused on productivity and content workflows, built with practical full-stack patterns.',
      'url': 'https://github.com/SadeepaNHerath/MetaScribe',
    },
    {
      'title': 'Mazex Website',
      'description': 'Continuous UI and feature improvements delivered through pull requests, form enhancements, and admin-focused updates.',
      'url': 'https://github.com/SadeepaNHerath/mazex-website',
    },
    {
      'title': 'Open_Books',
      'description': 'A repository focused on book-related tooling and iterative improvements through regular commits.',
      'url': 'https://github.com/SadeepaNHerath/Open_Books',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      itemCount: projectDetails.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showProjectDetails(context, index),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/work_$index.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showProjectDetails(BuildContext context, int index) {
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
                  'assets/work_$index.jpg',
                  fit: BoxFit.fitWidth,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                projectDetails[index]['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                projectDetails[index]['description']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _openProjectLink(projectDetails[index]['url']!),
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