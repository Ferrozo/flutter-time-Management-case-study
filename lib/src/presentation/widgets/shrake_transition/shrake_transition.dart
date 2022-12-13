import 'package:flutter/material.dart';

class ShrakeTransition extends StatelessWidget {
  const ShrakeTransition({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.offset = 140.0,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final double offset;
  final Axis? axis;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOut,
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration,
      child: child,
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0.0)
              : Offset(0.0, value * offset),
          child: child,
        );
      },
    );
  }
}
