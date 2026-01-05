
import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/pages/change_username.dart';
import 'package:authapp/pages/delete_account.dart';
import 'package:authapp/pages/login_page.dart';
import 'package:authapp/pages/reset_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        setState(() {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route)=> false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account Successfully logged out!')),
          );
          _errorMessage = '';
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
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Authentication App'),
            const Spacer(),
            if (user != null)
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  String displayName = "Unknown";

                  if (snapshot.hasData && snapshot.data!.exists) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    displayName = "${data['firstName']} ${data['lastName']}";

                  }

                  return Row(
                    children: [
                      const Icon(Icons.person),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(displayName),
                        ),
                      ),
                    ],
                  );
                },
              )
            else
              const Text("User: Unknown"),
          ],
        ),
      ),
      body: SafeArea(
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
                  'Welcome, ${user!.displayName ?? 'User'} ' ,
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
            const Spacer(),
            Text(_errorMessage, style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }
}
