import 'dart:math';
import 'package:flutter/material.dart';

import '../widgets/about_me_section.dart';
import '../widgets/app_bar.dart';
import '../widgets/profile_info_section.dart';
import '../widgets/recent_work_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/tab_navigation.dart';

class PortfolioDetailPage extends StatefulWidget {
  const PortfolioDetailPage({super.key});

  @override
  PortfolioDetailPageState createState() => PortfolioDetailPageState();
}

class PortfolioDetailPageState extends State<PortfolioDetailPage>
    with SingleTickerProviderStateMixin {
  int selectedTab = 0; // 0: Introduction, 1: Skills, 2: Recent Work
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      drawer: SlideTransition(
        position:
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
            .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: _buildAcademicQualificationDrawer(),
      ),
      endDrawer: SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: _buildAchievementDrawer(),
      ),
      body: Stack(
        children: [
          // Particle Background
          _buildParticleBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar with integrated drawers
                Builder(
                  builder: (context) => AppBarWidget(
                    onOpenNotificationDrawer: () {
                      _controller.forward();
                      Scaffold.of(context).openDrawer();
                    },
                    onOpenAccountDrawer: () {
                      _controller.forward();
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
                //Profile Info Section
                const ProfileInfoSection(),
                const SizedBox(height: 30),
                TabNavigationWidget(selectedTab: selectedTab,
                  onTabChanged: (index){
                    setState(() {
                      selectedTab = index;
                    });
                  },),

                const SizedBox(height: 20),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero)
                              .animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      key: ValueKey<int>(selectedTab),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Floating Action Button (FAB)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                // Add refresh or custom action here
              },
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (selectedTab == 0) {
      return const AboutMeSection();
    } else if (selectedTab == 1) {
      return const SkillsSection();
    } else {
      return RecentWorkSection();
    }
  }

  // Qualification Drawer
  Widget _buildAcademicQualificationDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xff2443b5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Drawer Header
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 16.0,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.limeAccent,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Academic\nQualifications",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.limeAccent,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            //Academic Details
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    _buildQualificationItem(
                      "A/Level",
                      "Maliyadeva College, Kurunegala",
                      "2023",
                      """
                      Z-Score: 2.1919
                      Combined Maths: A
                      Physics: A
                      ICT: A
                      """,
                    ),
                    _buildQualificationItem(
                      "ICD Program",
                      "ICET Panadura",
                      "2024",
                      """
                      Full-stack development
                      React framework
                      Node.js
                      MySQL databases
                      Java programming
                      Web development
                      Back-end development
                      """,
                    ),
                    _buildQualificationItem(
                      "Bsc(hons) Artificial Intelligence",
                      "University of Moratuwa",
                      "2025",
                      """
                      Waiting for the intake
                      """,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildQualificationItem(
      String title,
      String institution,
      String year,
      String description,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.limeAccent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Institution: $institution",
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            year,
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            description,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events, size: 40, color: Colors.limeAccent),
                  SizedBox(width: 16),
                  Text(
                    "Achievements &\nCertifications",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.limeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildAchievementItem("Full-Stack Developer Certification",
                      "Issued by ICET - March 2025"),
                  _buildAchievementItem(
                    "Best UI Design",
                    "My team won prize for Best UI Design at Industry Minds Pre-Launch 2024",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.limeAccent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildParticleBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(
        painter: _ParticlePainter(),
        size: MediaQuery.of(context).size,
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.2);
    final random = Random();
    for (int i = 0; i < 150; i++) {
      double dx = random.nextDouble() * size.width;
      double dy = random.nextDouble() * size.height;
      double radius = random.nextDouble() * 3 + 1;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
