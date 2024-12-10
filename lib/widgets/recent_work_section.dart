import 'package:flutter/material.dart';

class RecentWorkSection extends StatelessWidget {
  RecentWorkSection({super.key});

  final List<Map<String, String>> projectDetails = [
    {
      'title': 'Task Master',
      'description': 'To-Do app built using Electron.js! Get reminders so you never miss a thing.',
    },
    {
      'title': 'Book Management System',
      'description': 'A cli project to help manage and organize books in a library.',
    },
    {
      'title': 'Aero Cast',
      'description': 'A web application for check weather forecast details.',
    },
    {
      'title': 'WeCare Health Management System',
      'description': 'This is a project focused on managing and tracking health information for individuals.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      itemCount: 6,
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
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}