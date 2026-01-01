
import 'package:authapp/app/mobile/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void getStartedWith() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('FirstTime', false);
    if (mounted) {
      setState(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AuthWrapper()),
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome.json'),
            Text(
              "Welcome to our authentication app",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 100),
            FilledButton(
              onPressed: getStartedWith,
              style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 40)),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
