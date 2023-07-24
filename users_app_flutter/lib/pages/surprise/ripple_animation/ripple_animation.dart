import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users_app_flutter/pages/surprise/ripple_animation/riple_model.dart';

/// This is a copy of https://pub.dev/packages/awesome_ripple_animation that
/// just adds [animationController] param to avoid controller leaks and let
/// widgets to sync animations with their own ones.
class RippleAnimation extends StatefulWidget {
  const RippleAnimation({
    this.animationController,
    Key? key,
    required this.child,
    required this.size,
    required this.minRadius,
    this.color = Colors.teal,
    this.repeat = false,
    this.delay = const Duration(milliseconds: 0),
    this.duration = const Duration(milliseconds: 2300),
    this.ripplesCount = 60,
  }) : super(key: key);

  final AnimationController? animationController;
  final Widget child;
  final Size size;
  final Duration delay;
  final double minRadius;
  final Color color;
  final int ripplesCount;
  final Duration duration;
  final bool repeat;

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  Widget get child => widget.child;

  double get radius => widget.minRadius;

  Duration get delay => widget.delay;

  Duration get duration => widget.duration;

  bool get repeat => widget.repeat;

  Color get color => widget.color;

  int get rippleCount => widget.ripplesCount;

  bool get isParentController => widget.animationController != null;

  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.size.width,
        height: widget.size.height,
        child: CustomPaint(
          painter: AnimatedCircle(animationController,
              minRadius: radius,
              wavesCount: rippleCount + 2,
              color: color,
              key: UniqueKey()),
          child: child,
        ));
  }

  @override
  void initState() {
    animationController = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: duration,
        );

    if (!isParentController) {
      Timer(delay, () {
        repeat ? animationController!.repeat() : animationController!.forward();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    if (!isParentController) {
      animationController!.dispose();
    }

    super.dispose();
  }
}
