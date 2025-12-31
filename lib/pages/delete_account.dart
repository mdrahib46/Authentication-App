import 'package:authapp/appp/mobile/auth_service.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  String _errorMessage = '';

  Future<void> deleteAccount() async {
    try {
      await authService.value.deleteAccount(
        userEmail: userEmailController.text,
        userPassword: userPasswordController.text,
      );

      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account has been deleted...!")),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
        );
      }

    } on FirebaseAuthException catch (e) {
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
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: userEmailController,
                  decoration: InputDecoration(hintText: 'Email')),
              const SizedBox(height: 10),
              TextFormField(
                controller: userPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: 'Password')),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: (){
                  deleteAccount();
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
