import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/auth_provider.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  // Store the selected radio button value
  String _selectedValue = "";

  // Define variables to track the checked state of checkboxes
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  // To store the selected dropdown item
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getEmail(),
          getPassword(),
          getRadioButtonQuestion(),
          getCheckboxQuestion(),
          getDropdownQuestion(),
          getFormButtons(authProvider, context),
        ],
      ),
    );
  }

  Padding getEmail() {
    var authProvider = context.read<AuthProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email address.';
          } else if (!authProvider.isEmailValid(value)) {
            return 'Please enter a valid email address.';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Padding getPassword() {
    var authProvider = context.read<AuthProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ),
        validator: (value) {
          if (!authProvider.isPasswordValid(value!)) {
            return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
          } else {
            return null;
          }
        },
      ),
    );
  }

  bool isPasswordValid(String password) {
    // Define your password validation rules here
    const minLength = 8;
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

  Padding getRadioButtonQuestion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Radio Button Question:'),
          Radio<String>(
            value: 'Radio Option 1',
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
          const Text('Option 1'),
          Radio<String>(
            value: 'Radio Option 2',
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
          const Text('Option 2'),
        ],
      ),
    );
  }

  Column getCheckboxQuestion() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Checkbox Question:'),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _isChecked1,
              onChanged: (value) {
                setState(() {
                  _isChecked1 = value!;
                });
              },
            ),
            const Text('Option 1'),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _isChecked2,
              onChanged: (value) {
                setState(() {
                  _isChecked2 = value!;
                });
              },
            ),
            const Text('Option 2'),
          ],
        ),
      ],
    );
  }

  Padding getDropdownQuestion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Dropdown Question:'),
          const SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedItem, // The selected item
            onChanged: (newValue) {
              setState(() {
                _selectedItem = newValue!;
              });
            },
            items: const [
              DropdownMenuItem(
                value: 'Option 1', // Unique value for Option 1
                child: Text('Option 1'),
              ),
              DropdownMenuItem(
                value: 'Option 2', // Unique value for Option 2
                child: Text('Option 2'),
              ),
              DropdownMenuItem(
                value: 'Option 3', // Unique value for Option 3
                child: Text('Option 3'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Center getFormButtons(AuthProvider appState, BuildContext context) {
    return Center(
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
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
