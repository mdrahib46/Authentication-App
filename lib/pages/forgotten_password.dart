import 'package:authapp/app/mobile/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/constants.dart';

class ForgottenPassword extends StatefulWidget {
  const ForgottenPassword({super.key});

  @override
  State<ForgottenPassword> createState() => _ForgottenPasswordState();
}

class _ForgottenPasswordState extends State<ForgottenPassword> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  void _resetPassword() async {
    try {
      await authService.value.forgotPassword(userEmail: _emailController.text.trim());
      if (mounted) {
        setState(() {
          _errorMessage = '';
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Email has been sent"),
                content: Text('Reset password email has been sent to your mail..!'),
                actions: [TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text('Close'))],
              );
            },
          );
        });

      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? "Something went wrong";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Lottie.asset('assets/lotties/forgoPass.json', repeat: false),
              ),
              Text('Forgot Password', style: kTextStyle.pageTitle),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "Enter you email address";
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: ' Account Email'),
              ),
              const SizedBox(height: 10),

              FilledButton(onPressed: _resetPassword, child: Text("Forgot Password")),
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
