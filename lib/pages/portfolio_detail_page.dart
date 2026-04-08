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
  int selectedTab = 0; // 0: Summary, 1: Skills, 2: Recent Work
  int previousTab = 0;
  bool _showAppBar = false;
  bool _showProfile = false;
  bool _showTabs = false;
  bool _showContent = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _startIntroReveal();
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
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          _controller.reverse();
        }
      },
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          _controller.reverse();
        }
      },
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
                _buildRevealWrapper(
                  visible: _showAppBar,
                  beginOffset: const Offset(0, -0.03),
                  durationMs: 300,
                  child: Builder(
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
                ),
                //Profile Info Section
                _buildRevealWrapper(
                  visible: _showProfile,
                  beginOffset: const Offset(0, 0.03),
                  durationMs: 420,
                  child: const ProfileInfoSection(),
                ),
                const SizedBox(height: 30),
                _buildRevealWrapper(
                  visible: _showTabs,
                  beginOffset: const Offset(0, 0.03),
                  durationMs: 520,
                  child: TabNavigationWidget(selectedTab: selectedTab,
                    onTabChanged: (index){
                      _changeTab(index);
                    },),
                ),

                const SizedBox(height: 20),
                Expanded(
                  child: _buildRevealWrapper(
                    visible: _showContent,
                    beginOffset: const Offset(0, 0.04),
                    durationMs: 620,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        final isIncoming = child.key == ValueKey<int>(selectedTab);
                        final movingForward = selectedTab >= previousTab;
                        final beginOffset = isIncoming
                            ? Offset(movingForward ? 0.08 : -0.08, 0.0)
                            : Offset(movingForward ? -0.08 : 0.08, 0.0);

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: beginOffset,
                              end: Offset.zero,
                            ).animate(animation),
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
                _changeTab((selectedTab + 1) % 3);
              },
              backgroundColor: Colors.deepPurple,
              tooltip: 'Switch section',
              child: const Icon(Icons.swap_horiz),
            ),
          ),
        ],
      ),
    );
  }

  void _changeTab(int index) {
    if (index == selectedTab) {
      return;
    }
    setState(() {
      previousTab = selectedTab;
      selectedTab = index;
    });
  }

  void _startIntroReveal() {
    Future.delayed(const Duration(milliseconds: 60), () {
      if (!mounted) return;
      setState(() => _showAppBar = true);
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      setState(() => _showProfile = true);
    });
    Future.delayed(const Duration(milliseconds: 240), () {
      if (!mounted) return;
      setState(() => _showTabs = true);
    });
    Future.delayed(const Duration(milliseconds: 320), () {
      if (!mounted) return;
      setState(() => _showContent = true);
    });
  }

  Widget _buildRevealWrapper({
    required bool visible,
    required Offset beginOffset,
    required int durationMs,
    required Widget child,
  }) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: durationMs),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : beginOffset,
        duration: Duration(milliseconds: durationMs),
        curve: Curves.easeOutCubic,
        child: child,
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
                      "Professional Certificate",
                      "ICET Panadura",
                      "2024",
                      """
                      Comprehensive full-stack development training
                      Java and web engineering fundamentals
                      Backend and database-focused implementation
                      """,
                    ),
                    _buildQualificationItem(
                      "BSc (Hons) in Artificial Intelligence",
                      "University of Moratuwa",
                      "2025 - Present",
                      """
                      AI undergraduate pathway focused on intelligent systems,
                      practical software engineering, and modern AI tooling.
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
                    "Achievements &\nCommunity",
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
                    "GitHub Profile Achievements",
                    "Public Sponsor, Galaxy Brain, Pull Shark x2, Starstruck, Pair Extraordinaire, YOLO, and Quickdraw.",
                  ),
                  _buildAchievementItem(
                    "Open Source Activity",
                    "Active contributions across personal and collaborative repositories with consistent commit history.",
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
