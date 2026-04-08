import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f2027),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 40),
            _buildSectionTitle("Summary"),
            const SizedBox(height: 20),
            _buildAnimatedCard(
              "AI undergraduate at the University of Moratuwa and full-stack developer focused on intelligent software solutions. Skilled in Java, JavaScript, Spring Boot, React, and modern AI-oriented development workflows. Open to collaboration opportunities in AI-driven software engineering.",
            ),
            const SizedBox(height: 40),
            _buildSectionTitle("Experience"),
            const SizedBox(height: 20),
            _buildHighlightCard([
              "Full-Stack Developer and AI Specialist working on practical, user-focused software projects.",
              "Built and improved web applications with JavaScript/TypeScript, React, Angular, Node.js, and Spring Boot.",
              "Contributed to collaborative repositories with continuous commits, pull requests, and code reviews.",
              "Currently exploring deep learning, natural language processing, cloud-native development, and PWAs.",
            ]),
            const SizedBox(height: 40),
            _buildSectionTitle("Education"),
            const SizedBox(height: 20),
            _buildHighlightCard([
              "University of Moratuwa - Bachelor\'s in Artificial Intelligence (Undergraduate).",
              "iCET Institute - Professional Certificate in Full-Stack Development.",
              "Maliyadeva College, Kurunegala - Secondary education with strong mathematics and science foundation.",
            ]),
            const SizedBox(height: 40),
            _buildSectionTitle("Certifications"),
            const SizedBox(height: 20),
            _buildHighlightCard([
              "Professional Certificate in Full-Stack Development (iCET).",
              "Hands-on project experience across frontend, backend, databases, API integration, and deployment workflows.",
              "Continuous learning in AI development practices and modern software engineering standards.",
            ]),
            const SizedBox(height: 40),
            _buildSectionTitle("Skill & Tools"),
            const SizedBox(height: 20),
            _buildSkillChips([
              "Java",
              "JavaScript",
              "TypeScript",
              "Spring Boot",
              "React",
              "Angular",
              "Node.js",
              "Flutter",
              "Dart",
              "Python",
              "MySQL",
              "Git",
              "Postman",
              "Figma",
              "REST APIs",
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - value)),
            child: const Center(
              child: Text(
                "About Me",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.limeAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 12.0,
                      color: Colors.black45,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.greenAccent,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildAnimatedCard(String text) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.black38,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white70,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildHighlightCard(List<String> highlights) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.black38,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: highlights
            .map(
              (highlight) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    highlight,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: skills.map((skill) {
        return Chip(
          label: Text(skill),
          backgroundColor: Colors.greenAccent.withOpacity(0.25),
          labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
          elevation: 3,
          shadowColor: Colors.black38,
        );
      }).toList(),
    );
  }

}
