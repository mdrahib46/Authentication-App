import 'package:authapp/constants/constants.dart';
import 'package:authapp/pages/change_username.dart';
import 'package:authapp/pages/delete_account.dart';
import 'package:authapp/pages/reset_password.dart';
import 'package:authapp/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentication App")),
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
                  child: Text('Welcome, User', style: kTextStyle.pageTitle),
                ),
              ),
              const SizedBox(height: 10),

              ListTile(
                title: Text("Change Username"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeUsername()),
                  );
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
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
