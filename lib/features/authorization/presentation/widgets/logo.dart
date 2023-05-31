import 'package:flutter/material.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../styles/styles.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimationYDown(
      delay: 1,
      child: Column(
        children: [
          Text(
            'TRIPMAN',
            style: kSFProDisplayBold.copyWith(
              fontSize: 32,
              letterSpacing: 6.4,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Путешествия по\nРеспублике Башкортостан',
            textAlign: TextAlign.center,
            style: kSFProDisplayRegular.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
