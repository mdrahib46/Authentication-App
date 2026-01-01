import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  /// Sign in
  Future<UserCredential> signIn({
    required String userEmail,
    required String userPassword,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
  }

  /// Create account
  Future<UserCredential> createAccount({
    required String userEmail,
    required String userPassword,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Reset password using current password
  Future<void> resetPasswordFromCurrentPass({
    required String userEmail,
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = currentUser;
    if (user == null) throw Exception("User not logged in");

    final credential = EmailAuthProvider.credential(
      email: userEmail,
      password: oldPassword,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  /// forgot password
  Future<void> forgotPassword({required String userEmail}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: userEmail);
  }

  /// Update user name
  Future<void> updateUserName({required String username}) async {
    final user = currentUser;
    if (user == null) throw Exception("User not logged in");

    await user.updateDisplayName(username);
    await user.reload();
  }

  /// Delete account
  Future<void> deleteAccount({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      final user = currentUser;
      if (user == null) throw Exception("User not logged in");

      final credential = EmailAuthProvider.credential(
        email: userEmail,
        password: userPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.delete();
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Account deletion failed");
    }
  }
}
