import 'package:authapp/appp/mobile/auth_wrapper.dart';
import 'package:authapp/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key, required this.isFirsTime});

  final bool isFirsTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.teal
            )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.teal
              )
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: Size(double.infinity, 40)
          )
        )
      ),
      home: isFirsTime ? WelcomePage() : AuthWrapper(),
    );
  }
}
