import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationUtils {
  static void pushWithFade({
    required BuildContext context,
    required Widget page,
    Duration animationDuration = const Duration(milliseconds: 250),
  }) =>
      Navigator.of(context).push(
        PageTransition(
          duration: animationDuration,
          type: PageTransitionType.fade,
          child: page,
        ),
      );
}
