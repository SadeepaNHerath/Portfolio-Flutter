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
            _buildSectionTitle("Introduction"),
            const SizedBox(height: 20),
            _buildAnimatedCard(
              "Hello! I am Sadeepa Herath, a passionate Fullstack Developer.",
            ),
            const SizedBox(height: 40),
            _buildSectionTitle("What I Do"),
            const SizedBox(height: 20),
            _buildSpecializationRow(
              Icons.code,
              "Fullstack Developer",
              "Building full-stack applications.",
            ),
            const SizedBox(height: 20),
            _buildSpecializationRow(
              Icons.design_services,
              "Web Development",
              "Designing visually appealing and innovative interfaces.",
            ),
            const SizedBox(height: 40),
            _buildSectionTitle("Key Highlights"),
            const SizedBox(height: 20),
            _buildHighlightCard([
              "Expert in Spring Boot & Angular.",
              "Proficient in full-stack development with modern frameworks.",
              "Experienced in deploying and maintaining web applications.",
              "Committed to solving complex problems with innovative solutions.",
            ]),
            const SizedBox(height: 40),
            _buildSectionTitle("Skill & Tools"),
            const SizedBox(height: 20),
            _buildSkillChips([
              "Flutter",
              "Dart",
              "Java",
              "JavaScript",
              "React Native",
              "Node.js",
              "Electron.js",
              "MySQL",
              "Maven",
              "Spring Boot",
              "UI-UX Design",
              "REST APIs",
              "GIT",
              "Figma",
            ]),
            const SizedBox(height: 40),
            _buildSectionTitle("What People Say"),
            const SizedBox(height: 20),
            _buildTestimonialCard(
              "Sadeepa is an incredibly talented developer. His attention to detail and commitment to excellence make him a pleasure to work with!",
            ),
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

  Widget _buildSpecializationRow(
      IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.greenAccent.withOpacity(0.15),
          child: Icon(icon, size: 30, color: Colors.greenAccent),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              )
            ],
          ),
        ),
      ],
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

  Widget _buildTestimonialCard(String testimonial) {
    return Container(
      padding: const EdgeInsets.all(24.0),
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
        testimonial,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white70,
          fontStyle: FontStyle.italic,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
