import 'package:authapp/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final bool  isFirstTime = sharedPreferences.getBool('isFirstTime') ?? true;


  runApp(AuthenticationApp(isFirsTime:  isFirstTime,));
}

