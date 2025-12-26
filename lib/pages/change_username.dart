import 'package:authapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Lottie.asset('assets/lotties/Username.json'),
              Text("Update Username", style: kTextStyle.pageTitle),
              const SizedBox(height: 24),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'User name has been updated...!',
                        style: TextStyle(color: Colors.white),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.teal.shade900,
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                ),
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
