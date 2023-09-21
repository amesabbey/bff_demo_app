import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      loggedInUser = user;
      notifyListeners();
    });
  }

  User? loggedInUser;

  User? get user => loggedInUser;

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Handle login errors and throw an exception with a specific message
      throw FirebaseAuthException(
        code: 'signInFailed',
        message: 'Invalid email or password',
      );
    }
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    loggedInUser = null;
    Navigator.of(context).pushReplacementNamed('/');
    notifyListeners();
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Handle registration errors and throw an exception with a specific message
      throw FirebaseAuthException(
        code: 'registrationFailed',
        message: e.toString(),
      );
    }
    notifyListeners();
  }

  bool isEmailValid(String email) {
    // Define a regex pattern for a valid email address
    const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

    // Create a RegExp object with the email pattern
    final regExp = RegExp(emailPattern);

    // Use the RegExp's hasMatch method to check if the input matches the pattern
    return regExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    // Define your password validation rules here
    const minLength = 6;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    final noSpaces = !password.contains(' ');

    // Check if all rules are met
    return password.length >= minLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigit &&
        hasSpecialChar &&
        noSpaces;
  }
}
