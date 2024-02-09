import 'package:bff_demo_app/settings/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  void _performLogout(BuildContext context) {
    var authProvider = context.read<AuthProvider>();
    authProvider.logout(context); // Pass the context for navigation
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Are you sure you want to log out?'),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/dashboard');
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _performLogout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }
}
