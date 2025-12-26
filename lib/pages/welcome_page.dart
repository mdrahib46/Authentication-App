import 'package:authapp/pages/login_page.dart';
import 'package:authapp/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Lottie.asset('assets/lotties/welcome.json'),
            Text(
              "Welcome to out authentication app",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 100),
            FilledButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
              ),
              child: const Text('Register'),
            ),
            OutlinedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
            }, style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 40),
            ), child: const Text('Login'),),
          ],
        ),
      ),
    );
  }
}
