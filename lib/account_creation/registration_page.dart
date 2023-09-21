import 'package:bff_demo_app/settings/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (!authProvider.isEmailValid(value!)) {
                      return 'Please enter a valid email address.';
                    } else {
                      return null;
                    }
                  }),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // Hide password text
                validator: (value) {
                  if (!authProvider.isPasswordValid(value!)) {
                    return 'Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final scaffoldContext = ScaffoldMessenger.of(context);

                          try {
                            // Call the registration method from AuthProvider
                            await Provider.of<AuthProvider>(context, listen: false)
                                .registerWithEmailAndPassword(email, password);

                            scaffoldContext.showSnackBar(
                              const SnackBar(
                                content: Text('Registration successful!'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            // Navigate to a new screen or perform any other actions
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
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
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
