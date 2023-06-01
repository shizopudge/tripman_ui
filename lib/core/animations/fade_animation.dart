import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  const FadeAnimation({
    super.key,
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween().tween(
      'opacity',
      Tween(
        begin: 0.0,
        end: 1.0,
      ),
      duration: const Duration(milliseconds: 500),
    );
    return PlayAnimationBuilder(
      tween: tween.parent,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation.get(
          'opacity',
        ),
        child: child,
      ),
    );
  }
}
