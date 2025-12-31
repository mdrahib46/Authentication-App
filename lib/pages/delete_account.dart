import 'package:authapp/appp/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {

  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  String _errorMessage = '';

  Future<void> deleteAccount() async{

    try{
      await authService.value.deleteAccount(userEmail: userEmail.text.trim(), userPassword: userPassword.text.trim());
      if(mounted){
        setState(() {
          _errorMessage = '';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Account has been deleted...!',
                style: TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.teal.shade900,
            ),
          );
        });
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch(e){
      setState(() {
        _errorMessage = e.message ?? "Something went wrong..!";
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
                child: Lottie.asset('assets/lotties/TrashBin.json', repeat: false),
              ),
              const SizedBox(height: 10),
              Text('Delete Account', style: kTextStyle.pageTitle),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              const SizedBox(height: 10),
              TextFormField(decoration: InputDecoration(hintText: 'Password')),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Text("Warning...!"),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                          ],
                        ),
                        content: Text("Do you really want to delete your account ?"),
                        actions: [
                          TextButton(
                            onPressed: deleteAccount,
                            child: Text("Delete"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Delete"),
              ),
              Text(_errorMessage, style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
