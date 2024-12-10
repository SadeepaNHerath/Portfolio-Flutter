import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a2a6c),
            Color(0xFFb21f1f),
            Color(0xFFfdbb2d),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Skills",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Skill items
            _buildSkillItem('Flutter Development', 0.5, 0),
            _buildSkillItem('Dart Programming', 0.7, 1),
            _buildSkillItem('Electron.js', 0.4, 2),
            _buildSkillItem('REST API Integration', 0.9, 3),
            _buildSkillItem('Database Management (MySQL)', 0.8, 4),
            _buildSkillItem('JavaFX', 0.8, 5),
            _buildSkillItem('Java', 0.95, 6),
            _buildSkillItem('Responsive Design', 0.7, 7),
            _buildSkillItem('Backend Development (Spring Boot)', 0.8, 8),
            _buildSkillItem('Web Development (HTML, CSS, JS)', 0.9, 9),
            _buildSkillItem('Single Page Application (Angular)', 0.7, 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillItem(String skill, double proficiency, int index) {
    return AnimatedSlide(
      offset: const Offset(0, 0.2),
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 300 + (index * 100)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: proficiency),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[800],
                          valueColor: AlwaysStoppedAnimation(
                            _getProgressColor(value),
                          ),
                        ),
                      ),
                      Text(
                        '${(value * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: proficiency,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getProgressColor(proficiency),
                                Colors.white.withOpacity(0.3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(double proficiency) {
    if (proficiency >= 0.8) {
      return Colors.greenAccent;
    } else if (proficiency >= 0.6) {
      return Colors.amber;
    }
    return Colors.redAccent;
  }
}