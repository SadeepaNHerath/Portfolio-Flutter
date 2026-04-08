import 'package:flutter/material.dart';
import 'package:portfolio/pages/portfolio_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  static final Uri _linkedinUri =
      Uri.parse('https://www.linkedin.com/in/sadeepanherath/');
  static final Uri _githubUri = Uri.parse('https://github.com/SadeepaNHerath');
  static final Uri _emailUri = Uri.parse('mailto:sadeepahearth@gmail.com');
  static final Uri _cvUriLocal =
      Uri.file('/Users/sadeepaherath/Downloads/Profile.pdf');
  static final Uri _cvUriWeb = Uri.parse(
    'https://www.linkedin.com/in/sadeepanherath/',
  );

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.06,
                horizontal: screenWidth * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenHeight * 0.12,
                    backgroundImage: const AssetImage('assets/icon.png'),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  const Text(
                    'Welcome to My Portfolio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Discover the Projects Shaping My Digital Story',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PortfolioDetailPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: screenHeight * 0.022,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Contact',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialIconButton(
                              icon: Icons.work_outline,
                              tooltip: 'LinkedIn',
                              onTap: () => _launchExternal(context, _linkedinUri),
                            ),
                            _socialIconButton(
                              icon: Icons.code,
                              tooltip: 'GitHub',
                              onTap: () => _launchExternal(context, _githubUri),
                            ),
                            _socialIconButton(
                              icon: Icons.email_outlined,
                              tooltip: 'Email',
                              onTap: () => _launchExternal(context, _emailUri),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => _downloadCv(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.yellow),
                          ),
                          icon: const Icon(Icons.download, color: Colors.yellow),
                          label: const Text(
                            'Download CV',
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  static Future<void> _downloadCv(BuildContext context) async {
    final bool openedLocal = await _tryLaunch(_cvUriLocal);
    if (!openedLocal) {
      final bool openedWeb = await _tryLaunch(_cvUriWeb);
      if (!openedWeb && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open CV link right now.'),
          ),
        );
      }
    }
  }

  static Future<void> _launchExternal(BuildContext context, Uri uri) async {
    final bool opened = await _tryLaunch(uri);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open link right now.'),
        ),
      );
    }
  }

  static Future<bool> _tryLaunch(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }
}