import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF009383);
    const unselectedColor = Colors.grey;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.battery_std), label: "BMS"),
        BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.tune), label: "Control"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Params"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
