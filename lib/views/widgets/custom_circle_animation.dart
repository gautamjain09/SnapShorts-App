import 'package:flutter/material.dart';

class CustomCircleAnimation extends StatefulWidget {
  final Widget child;
  const CustomCircleAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _CustomCircleAnimationState createState() => _CustomCircleAnimationState();
}

class _CustomCircleAnimationState extends State<CustomCircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 5000,
      ),
    );
    animationController.forward();
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
      child: widget.child,
    );
  }
}
