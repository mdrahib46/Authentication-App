import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

 ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  /// Sign in application
  Future<UserCredential> signIn(
      {required String userEmail, required String userPassword,}) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: userEmail, password: userPassword);
  }

  /// Create New User
  Future<UserCredential> createAccount(
      {required String userEmail, required String userPassword }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail, password: userPassword);
  }

  /// Sign Out
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  /// Reset Password
  Future<void> resetPasswordFormCurrentPass ({required String userEmail}) async{
    await firebaseAuth.sendPasswordResetEmail(email: userEmail);
  }

  /// Update User Name
  Future<void> updateUserName({required String username}) async{
    await currentUser!.updateDisplayName(username);
  }

  /// Delete Account
  Future<void> deleteAccount({required String userEmail, required String userPassword}) async{
    AuthCredential credential = EmailAuthProvider.credential(email: userEmail, password: userPassword);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
  }





  
}