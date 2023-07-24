import 'package:flutter/material.dart';
import 'package:users_app_flutter/pages/users/users_page.dart';

class UsersApp extends StatelessWidget {
  const UsersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersPage(),
    );
  }
}
