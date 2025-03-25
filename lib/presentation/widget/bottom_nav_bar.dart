import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        context.go(index == 0 ? '/mood' : '/health');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: 'Mood'),
        BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'Health'),
      ],
    );
  }
}
