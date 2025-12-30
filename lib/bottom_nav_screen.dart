import 'package:authapp/appp/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/features/home_page.dart';
import 'package:authapp/pages/profile_page.dart';
import 'package:authapp/widgets/nab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List<Widget> pageList = [HomePage(), ProfilePage()];

  User? user = authService.value.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication App'), actions: [
        Text("User: "),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(user!.email ?? "Unknown"),
          ),
        )
      ],),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedIndex, child) {
          return pageList[selectedIndex];
        },
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
