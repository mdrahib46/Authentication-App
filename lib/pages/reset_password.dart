
import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String _errorMessage = '';

  Future<void> resetPassword() async {
    try {
      await authService.value.resetPasswordFromCurrentPass(
        userEmail: _emailController.text.trim(),
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _errorMessage = '';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password has been updated...!', style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.teal.shade900,
            ),
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

              Text('Reset Password', style: kTextStyle.pageTitle),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "Enter you email address";
                  }
                  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!_emailRegex.hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _oldPasswordController,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "Enter you old password";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Old Password'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _newPasswordController,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "Enter you new password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 character";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'New Password'),
              ),
              const SizedBox(height: 10),
              FilledButton(onPressed: resetPassword, child: Text("Reset Password")),
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
