import 'package:authapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentication App"),),
      body: SafeArea(
        child: SingleChildScrollView(
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
    );
  }
}
