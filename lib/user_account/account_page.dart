import 'package:bff_demo_app/user_account/profile_questionnaire.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileQuestionnairePage(),
              ),
            );
          }, 
          child: const Text('Update Profile')
        ),
      ],
    );
  }
}
