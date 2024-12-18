import 'package:flutter/material.dart';
import 'pages/user_bloc_page.dart';
import 'pages/user_cubit_page.dart';
import 'pages/user_notifier_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bloc'),
              Tab(text: 'Cubit'),
              Tab(text: 'Provider'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserBlocPage(),
            UserCubitPage(),
            UserNotifierPage(),
          ],
        ),
      ),
    );
  }
}
