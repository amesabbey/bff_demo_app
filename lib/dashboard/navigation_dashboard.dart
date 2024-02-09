import 'package:bff_demo_app/errors/page_not_found.dart';
import 'package:flutter/material.dart';

import '../user_account/account_page.dart';
import '../messaging/messages_page.dart';
import '../login/logout_page.dart';
import 'post_feed.dart';
import '../settings/settings_page.dart';

class NavigationDashboard extends StatefulWidget {
  const NavigationDashboard({super.key});

  @override
  State<NavigationDashboard> createState() => _NavigationDashboardState();
}

class _NavigationDashboardState extends State<NavigationDashboard> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const PostFeed();
        break;
      case 1:
        page = const AccountPage();
        break;
      case 2:
        page = const MessagesPage();
        break;
      case 3:
        page = const SettingsPage();
        break;
      case 4:
        page = const LogoutPage();
        break;
      default:
        page = const PageNotFound();
        break;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.account_circle),
                    label: Text('Account'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.question_answer),
                    label: Text('Messages'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
