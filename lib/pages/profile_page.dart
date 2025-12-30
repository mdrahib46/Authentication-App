import 'package:authapp/appp/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/pages/change_username.dart';
import 'package:authapp/pages/delete_account.dart';
import 'package:authapp/pages/login_page.dart';
import 'package:authapp/pages/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _errorMessage = '';
  User? user = authService.value.currentUser;

  Future<void> _logOut() async {
    try {
      await authService.value.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route)=> false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account Successfully logged out!')),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Welcome, ${user!.displayName} ' ,
                    style: kTextStyle.pageTitle,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ListTile(
                title: Text("Change Username"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeUsername()),
                  );
                  setState(() {});
                },
              ),
              ListTile(
                title: Text("Reset Password"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPassword()),
                  );
                },
              ),
              ListTile(
                title: Text("Delete Account"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteAccount()),
                  );
                },
              ),
              ListTile(
                title: Text("Log Out"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: _logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
