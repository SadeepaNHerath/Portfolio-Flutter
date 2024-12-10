import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback onOpenNotificationDrawer;
  final VoidCallback onOpenAccountDrawer;

  const AppBarWidget({
    super.key,
    required this.onOpenAccountDrawer,
    required this.onOpenNotificationDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0f2027),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onOpenNotificationDrawer,
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.greenAccent, size: 28),
                const SizedBox(width: 8),
                Text(
                  "Academic Qualifications",
                  style: TextStyle(
                    color: Colors.greenAccent.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onOpenAccountDrawer,
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.greenAccent, size: 28),
                const SizedBox(width: 8),
                Text(
                  "Achievements",
                  style: TextStyle(
                    color: Colors.greenAccent.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}