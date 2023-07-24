import 'package:flutter/material.dart';
import 'package:users_app_flutter/bloc/users_bloc.dart';
import 'package:users_app_flutter/model/user.dart';
import 'package:users_app_flutter/pages/surprise/surprise_page.dart';
import 'package:users_app_flutter/pages/users/user_card.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late final UsersBloc _usersBloc;
  final List<User> _users = [];

  bool _isLoading = false;

  @override
  void initState() {
    _usersBloc = UsersBloc();

    _usersBloc.usersStream.listen((users) {
      setState(() {
        _isLoading = false;

        _users.clear();
        _users.addAll(users);
      });
    });

    _isLoading = true;
    _usersBloc.fetchUsers();

    super.initState();
  }

  Widget _buildSurpriseButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SurprisePage(),
            ),
          );
        },
        child: const Text('Surprise!'),
      );

  Widget _buildLoader() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildContent() => ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];

          return UserCard(user: user);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Users Page Flutter'),
            _buildSurpriseButton(),
          ],
        ),
      ),
      body: _isLoading ? _buildLoader() : _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          _usersBloc.fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
