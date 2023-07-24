import 'package:flutter/material.dart';

class AnimationPageAppBar extends StatelessWidget {
  const AnimationPageAppBar({super.key});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.transparent,
        height: 50.0,
        margin: const EdgeInsets.only(top: 16.0),
        width: double.infinity,
        child: Row(
          children: [
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back_ios_new),
              iconSize: 32.0,
              onPressed: () => Navigator.of(context).pop(),
              padding: const EdgeInsets.only(
                left: 32.0,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 64.0),
                child: const Center(
                  child: Text(
                    'Q & A Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
