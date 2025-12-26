import 'package:authapp/constants/constants.dart';
import 'package:flutter/material.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, selectedIndex, child){
      return NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int value) {
          selectedPageNotifier.value = value;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      );
    });
  }
}
