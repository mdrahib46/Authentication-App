import 'package:authapp/appp/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/pages/forgotten_password.dart';
import 'package:authapp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();

  bool _isObSecureText = true;
  String _errorMessage = '';

  Future<void> _registerAccount() async {
    try {
      await authService.value.createAccount(
        userEmail: _emailTEController.text.trim(),
        userPassword: _passTEController.text,
      );

      _errorMessage = '';

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account successfully registered...!')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                width: 250,
                child: Lottie.asset(
                  'assets/lotties/register.json',
                  repeat: false,
                ),
              ),
              Text('Register Screen', style: kTextStyle.pageTitle),
              const SizedBox(height: 24),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter your email";
                  }
                  final _emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!_emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passTEController,
                obscureText: _isObSecureText,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      _isObSecureText = !_isObSecureText;
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_red_eye_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your password";
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 character';
                  }

                  return null;
                },
              ),
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _registerAccount,
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                ),
                child: Text("Register"),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgottenPassword(),
                    ),
                  );
                },
                child: Text('Reset Password'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
