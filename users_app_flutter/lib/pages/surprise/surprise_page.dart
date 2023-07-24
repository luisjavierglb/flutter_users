import 'package:flutter/material.dart';
import 'package:users_app_flutter/pages/surprise/ripple_animation/ripple_animation.dart';
import 'package:users_app_flutter/pages/surprise/widgets/icons_background.dart';
import 'widgets/app_bar.dart';
import 'widgets/logo.dart';

class SurprisePage extends StatefulWidget {
  const SurprisePage({Key? key}) : super(key: key);

  @override
  SurprisePageState createState() => SurprisePageState();
}

class SurprisePageState extends State<SurprisePage>
    with TickerProviderStateMixin {
  static const _colorGlobant1 = Color.fromARGB(255, 21, 75, 123);
  static const _colorGlobant2 = Color.fromARGB(255, 157, 205, 55);

  late AnimationController _animationController;
  late Animation<Color?> _colorGradient1Animation;
  late Animation<Color?> _colorGradient2Animation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Offset _scaleOriginOffset;

  Alignment _beginAlignment = Alignment.topCenter;
  Alignment _endAlignment = Alignment.bottomCenter;

  int _iterationIndex = 0;

  bool get _isFirstIteration => _iterationIndex == 0;

  bool get _isSecondIteration => _iterationIndex == 1;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationController.addStatusListener((status) {
      if (_isFirstIteration && status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          _initSecondIterationAnimations();
        });
      } else if (_isSecondIteration && status == AnimationStatus.reverse) {
        setState(() {
          _iterationIndex++;
        });
      }
    });

    _animationController.forward();
  }

  void _initSecondIterationAnimations() {
    _animationController.reset();
    const curve = Interval(0.8, 1.0);
    _colorGradient1Animation = ColorTween(
      begin: Colors.white30,
      end: _colorGlobant1,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: _animationController,
      ),
    );

    _colorGradient2Animation = ColorTween(
      begin: Colors.white30,
      end: _colorGlobant2,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: _animationController,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        curve: curve,
        parent: _animationController,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 20.0).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );

    _animationController.addListener(() {
      _beginAlignment = Alignment(
        _animationController.value - 1.0,
        -_animationController.value + 1.0,
      );
      _endAlignment = Alignment(
        _animationController.value,
        -_animationController.value,
      );
    });

    setState(() {
      _iterationIndex++;
    });

    _animationController.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final mq = MediaQuery.of(context);
    _scaleOriginOffset = Offset(mq.size.width / 8, 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedGlobantLogo() {
    Widget result;

    if (_isFirstIteration || _isSecondIteration) {
      result = Opacity(
        opacity: _isFirstIteration
            ? 1.0
            : _isSecondIteration
                ? _opacityAnimation.value
                : 0.0,
        child: Transform.scale(
          origin: _scaleOriginOffset,
          scale: _isFirstIteration
              ? 1.0
              : _isSecondIteration
                  ? _scaleAnimation.value
                  : 20.0,
          child: Image.asset(
            'assets/globant-logo.png',
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      result = const SizedBox();
    }

    if (_isFirstIteration) {
      final sizeWidth = MediaQuery.of(context).size.width / 2;
      result = SizedBox(
        width: sizeWidth,
        child: RippleAnimation(
          animationController: _animationController,
          color: _colorGlobant2,
          minRadius: MediaQuery.of(context).size.width * 0.8,
          repeat: false,
          ripplesCount: 6,
          size: Size(sizeWidth, sizeWidth),
          child: result,
        ),
      );
    }

    return result;
  }

  Widget _buildContent(
    BuildContext context,
    Widget? child,
  ) =>
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: _beginAlignment,
            end: _endAlignment,
            colors: [
              _isFirstIteration
                  ? Colors.white30
                  : _isSecondIteration
                      ? _colorGradient1Animation.value!
                      : _colorGlobant1,
              _isFirstIteration
                  ? Colors.white30
                  : _isSecondIteration
                      ? _colorGradient2Animation.value!
                      : _colorGlobant2,
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25,
          ),
          child: _buildAnimatedGlobantLogo(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenPadding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: _buildContent,
          ),
          Padding(
            padding: EdgeInsets.only(top: screenPadding.top),
            child: const AnimationPageAppBar(),
          ),
          Positioned(
            bottom: 8.0 + screenPadding.bottom,
            right: 8.0,
            child: const Logo(
              path: 'assets/flutter-logo.png',
              background: Colors.black87,
            ),
          ),
          Positioned(
            bottom: 8.0 + screenPadding.bottom,
            left: 8.0,
            child: const Logo(
              path: 'assets/globant-logo.png',
              background: Colors.white30,
            ),
          ),
          Positioned.fill(
            top: 100.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              opacity: _isFirstIteration || _isSecondIteration ? 0.0 : 1.0,
              child: IconsBackground(
                animationController: _animationController,
                initialNumIcons: MediaQuery.of(context).size.width ~/ 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
