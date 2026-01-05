import 'package:authapp/constants/constants.dart';
import 'package:authapp/features/home_page.dart';
import 'package:authapp/features/profile_page.dart';
import 'package:authapp/widgets/nab_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List<Widget> pageList = [HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {


    return Scaffold(

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
