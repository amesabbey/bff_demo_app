import 'package:bff_demo_app/settings/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email for the account.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final scaffoldContext = ScaffoldMessenger.of(context);

                    try {
                      // Call the login method from AuthProvider
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signInWithEmailAndPassword(email, password);

                      scaffoldContext.showSnackBar(
                        const SnackBar(
                          content: Text('Login successful!'),
                          duration: Duration(
                              seconds: 2),
                        ),
                      );

                      // Navigate to a new screen or perform any other actions
                      Navigator.of(context).pushReplacementNamed('/dashboard');
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        // Handle and display Firebase Authentication errors to the user
                        scaffoldContext.showSnackBar(
                          SnackBar(
                            content: Text(e.message ??
                                'An error occurred'), // Display the error message
                          ),
                        );
                      } else {
                        // Handle other types of exceptions or errors
                        scaffoldContext.showSnackBar(
                          const SnackBar(
                            content: Text('An error occurred'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
