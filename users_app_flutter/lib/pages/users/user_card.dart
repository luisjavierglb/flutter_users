import 'package:flutter/material.dart';
import 'package:users_app_flutter/model/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
        ),
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              4.0,
            ),
            child: SizedBox(
              height: 64.0,
              width: 64.0,
              child: Image.network(user.image),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name.fullName),
              Text(user.email),
            ],
          ),
        ],
      ),
    );
  }
}
