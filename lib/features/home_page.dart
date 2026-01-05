import 'package:authapp/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser;

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
                    print("Display Name: $displayName");
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
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Lottie.asset('assets/lotties/Home.json'),
                const SizedBox(height: 20,),
                Text('Authenticated', style: kTextStyle.pageTitle,),
                Text("Home page is under development", style: Theme.of(context).textTheme.bodyLarge,)
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
