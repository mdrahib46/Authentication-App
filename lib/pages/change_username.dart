import 'package:authapp/appp/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({super.key});

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final TextEditingController userNameController = TextEditingController();
  String _errorMessage = '';

  void updateUserName() async {
    /// This authService is coming form ValueNotifier()
    try {
      await authService.value.updateUserName(
        username: userNameController.text.trim(),
      );
      _errorMessage = '';

      if (mounted) {
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
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Something went wrong...!";
    }
  }

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
                controller: userNameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Change username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty && value.trim().isEmpty) {
                    return "Please enter your new user name...!";
                  }
                  return null;
                },
              ),
              Text(
                _errorMessage.toString() ?? '',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: updateUserName,
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
