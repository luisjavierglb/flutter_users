import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:users_app_flutter/model/user.dart';

class UsersBloc {
  final StreamController<List<User>> _usersStreamController =
      StreamController.broadcast();

  Stream<List<User>> get usersStream => _usersStreamController.stream;

  void dispose() {
    _usersStreamController.close();
  }

  Future<void> fetchUsers() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final response = await http.get(
      Uri.parse('https://randomuser.me/api/?results=15'),
    );

    if (response.statusCode == HttpStatus.ok) {
      final results = jsonDecode(response.body)['results'];
      final users = User.fromList(results);

      _usersStreamController.add(users);
    } else {
      throw Exception(
        'Failed to load users, err code: ${response.statusCode} and message: ${response.body}',
      );
    }
  }
}
