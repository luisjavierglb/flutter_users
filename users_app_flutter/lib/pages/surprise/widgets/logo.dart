import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.background,
    required this.path,
  });

  final Color background;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
      ),
      height: 50.0,
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 2.0,
        right: 8.0,
        top: 8.0,
      ),
      width: 50.0,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        width: 32.0,
      ),
    );
  }
}
