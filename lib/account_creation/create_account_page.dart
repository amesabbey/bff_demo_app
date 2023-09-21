import 'package:bff_demo_app/account_creation/create_account_form.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
  
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text('Create New Account'),
        CreateAccountForm(),
      ],
      )
    );
  }
}
