
import 'package:authapp/bottom_nav_screen.dart';
import 'package:authapp/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: authService.value.authStateChange, builder: (context, snapShot){
      if(snapShot.connectionState == ConnectionState.waiting){
        return  Scaffold(
          body: Center(child: CircularProgressIndicator(),),
        );
      }
      if(snapShot.hasData){
        return BottomNavScreen();
      }
      return LoginPage();
    });
  }
}
