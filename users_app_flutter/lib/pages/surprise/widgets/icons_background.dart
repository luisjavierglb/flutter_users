import 'dart:math';

import 'package:flutter/material.dart';

class IconsBackground extends StatefulWidget {
  const IconsBackground({
    required this.animationController,
    super.key,
    required this.initialNumIcons,
  });

  final AnimationController animationController;
  final int initialNumIcons;

  @override
  IconsBackgroundState createState() => IconsBackgroundState();
}

class IconsBackgroundState extends State<IconsBackground>
    with TickerProviderStateMixin {
  static const _maxIconSize = 150.0;
  static const List<IconData> _materialIcons = [
    // Logo icons. These two will be replaced by logos.
    Icons.abc, // Will be replaced by Globant logo
    Icons.abc, // Will be replaced by Globant logo
    Icons.wb_auto, // Will be replaced by Flutter logo
    Icons.wb_auto, // Will be replaced by Flutter logo

    // Material icons
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time_filled,
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.account_circle_rounded,
    Icons.adb,
    Icons.add_a_photo,
    Icons.alarm,
    Icons.add_location_alt_rounded,
    Icons.add_alert,
    Icons.color_lens_rounded,
    Icons.cake_sharp,
    Icons.album_sharp,
    Icons.dark_mode_sharp,
    Icons.fast_forward,
    Icons.favorite_outlined,
    Icons.gpp_good_rounded,
    Icons.grade_sharp,
    Icons.headset,
    Icons.ice_skating,
    Icons.insert_photo_rounded,
    Icons.keyboard_voice,
    Icons.language_outlined,
    Icons.library_add_check_rounded,
    Icons.mail,
    Icons.mark_email_read_sharp,
    Icons.new_releases,
    Icons.offline_pin_rounded,
    Icons.park_sharp,
    Icons.party_mode,
    Icons.qr_code,
    Icons.question_answer_rounded,
    Icons.quiz_rounded,
    Icons.recycling_outlined,
    Icons.tag,
    Icons.tag_faces_rounded,
    Icons.upload_rounded,
    Icons.verified,
    Icons.video_collection,
    Icons.wb_cloudy,
    Icons.wb_sunny_rounded,
    Icons.zoom_in,
  ];
  static final _random = Random();

  final List<double> _iconSizes = [];
  late final List<AnimationController> _iconAnimationControllers;
  late final List<Animation<double>> _iconSizeAnimations;
  late final List<Animation<double>> _iconRotationAnimations;
  late final List<Animation<double>> _iconOpacityAnimations;
  late final int _numIcons;

  @override
  void initState() {
    super.initState();

    _numIcons = widget.initialNumIcons;

    for (int i = 0; i < _numIcons; i++) {
      _iconSizes.add(
        _random.nextDouble() * _maxIconSize,
      );
    }

    _iconAnimationControllers = List<AnimationController>.generate(
      _numIcons,
      (index) => AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..repeat(reverse: true),
    );

    _iconSizeAnimations = List<Animation<double>>.generate(
      _numIcons,
      (index) {
        final begin = _random.nextDouble() * 0.8;
        final end = _random.nextDouble() * 1.0;

        return Tween<double>(begin: begin, end: end).animate(
          CurvedAnimation(
            curve: Curves.easeInOut,
            parent: _iconAnimationControllers[index],
          ),
        );
      },
    );

    _iconRotationAnimations = List<Animation<double>>.generate(
      _numIcons,
      (index) {
        final begin = _random.nextDouble() * (pi / 2);
        final end = _random.nextDouble() * (2 * pi);

        return Tween<double>(begin: begin, end: end).animate(
          CurvedAnimation(
            curve: Curves.easeInOut,
            parent: _iconAnimationControllers[index],
          ),
        );
      },
    );

    _iconOpacityAnimations = List<Animation<double>>.generate(
      _numIcons,
      (index) {
        final begin = _random.nextDouble() * 0.8;
        final end = _random.nextDouble() * 1.0;

        return Tween<double>(begin: begin, end: end).animate(
          CurvedAnimation(
            curve: const Interval(0.2, 0.8),
            parent: _iconAnimationControllers[index],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (final controller in _iconAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildIcon({
    required IconData iconData,
    required double size,
  }) {
    Widget result;

    if (iconData == Icons.abc) {
      result = SizedBox(
        height: size,
        width: size,
        child: Image.asset(
          'assets/globant-logo.png',
          fit: BoxFit.contain,
        ),
      );
    } else if (iconData == Icons.wb_auto) {
      result = SizedBox(
        height: size,
        width: size,
        child: Image.asset(
          'assets/flutter-logo.png',
          fit: BoxFit.contain,
        ),
      );
    } else {
      result = Icon(
        iconData,
        size: size,
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final columnCount = (screenWidth / _maxIconSize).ceil();

        return Stack(
          children: List.generate(
            _numIcons,
            (index) {
              final column = index % columnCount;
              final row = index ~/ columnCount;

              final x = column * _maxIconSize;
              final y = row * _iconSizes[index];

              final iconData = _materialIcons[_random.nextInt(
                _materialIcons.length,
              )];

              return Positioned(
                left: x,
                top: y,
                child: AnimatedBuilder(
                  animation: widget.animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _iconSizeAnimations[index].value,
                      child: Transform.rotate(
                        angle: _iconRotationAnimations[index].value,
                        child: Opacity(
                          opacity: _iconOpacityAnimations[index].value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: _buildIcon(
                    iconData: iconData,
                    size: _iconSizes[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
