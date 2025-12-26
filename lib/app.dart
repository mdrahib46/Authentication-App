import 'package:authapp/pages/welcome_page.dart';
import 'package:flutter/material.dart';


class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark)
      ),
      home: WelcomePage(),
    );
  }
}
