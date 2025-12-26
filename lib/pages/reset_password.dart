import 'package:authapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Lottie.asset(
                  'assets/lotties/forgoPass.json',
                  repeat: false,
                ),
              ),

              Text('Reset Password', style: kTextStyle.pageTitle,),
              const SizedBox(height: 10),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              const SizedBox(height: 10),
              TextFormField(decoration: InputDecoration(hintText: 'Old Password')),
              const SizedBox(height: 10),
              TextFormField(decoration: InputDecoration(hintText: 'New Password')),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Password has been updated...!',
                        style: TextStyle(color: Colors.white),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.teal.shade900,
                    ),
                  );


                },
                child: Text("Reset Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
