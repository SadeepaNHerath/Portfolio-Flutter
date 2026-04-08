import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfoSection extends StatefulWidget {
  const ProfileInfoSection({super.key});

  @override
  State<ProfileInfoSection> createState() => _ProfileInfoSectionState();
}

class _ProfileInfoSectionState extends State<ProfileInfoSection> {
  static bool _hasAnimatedCountersThisSession = false;
  late final bool _animateCounters;

  static final Uri _whatsappUri = Uri.parse('https://wa.me/qr/YFCMEVAQBMQTA1');
  static final Uri _linkedinUri =
      Uri.parse('https://www.linkedin.com/in/sadeepanherath/');
  static final Uri _githubUri = Uri.parse('https://github.com/SadeepaNHerath');
  static final Uri _emailUri = Uri.parse('mailto:sadeepahearth@gmail.com');

  @override
  void initState() {
    super.initState();
    _animateCounters = !_hasAnimatedCountersThisSession;
    _hasAnimatedCountersThisSession = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Stack(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/icon.png'),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.check, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          const Text(
            'Sadeepa Herath',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
            ),
          ),
          const SizedBox(height: 5),

          const Text(
            'AI Undergraduate | Full-Stack Developer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'University of Moratuwa | Panadura, Sri Lanka',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _launchExternal(_whatsappUri),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text(
                  'Chat With Me',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AnimatedStat(
                label: 'Projects',
                target: 37,
                animate: _animateCounters,
              ),
              _AnimatedStat(
                label: 'Contributions',
                target: 534,
                animate: _animateCounters,
              ),
              _AnimatedStat(
                label: 'Followers',
                target: 46,
                animate: _animateCounters,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () => _launchExternal(_linkedinUri),
                icon: const Icon(Icons.work_outline),
                label: const Text('LinkedIn'),
              ),
              OutlinedButton.icon(
                onPressed: () => _launchExternal(_githubUri),
                icon: const Icon(Icons.code),
                label: const Text('GitHub'),
              ),
              OutlinedButton.icon(
                onPressed: () => _launchExternal(_emailUri),
                icon: const Icon(Icons.email_outlined),
                label: const Text('Email'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> _launchExternal(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _AnimatedStat extends StatelessWidget {
  final String label;
  final int target;
  final bool animate;

  const _AnimatedStat({
    required this.label,
    required this.target,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: animate ? 0 : target, end: target),
          duration: Duration(milliseconds: animate ? 900 : 1),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Text(
              '$value+',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
