import 'package:flutter/material.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/constants/styles/styles.dart';
import '../../../../core/widgets/buttons/rounded_text_button.dart';

class TripNotFoundPage extends StatelessWidget {
  const TripNotFoundPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FadeAnimationYDown(
              delay: .5,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 20),
                  child: Icon(
                    Icons.arrow_back,
                    color: kBlack,
                    size: 28,
                  ),
                ),
              ),
            ),
            FadeAnimationYDown(
              delay: .5,
              child: Center(
                child: Text(
                  'Объект удалён или не найден.',
                  style: kSFProDisplayRegular.copyWith(
                    color: kBlack50,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            FadeAnimationYUp(
              delay: 1.2,
              child: Container(
                decoration: const BoxDecoration(
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: kBlack10,
                      offset: Offset(
                        2,
                        -4,
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: RoundedTextButton(
                    text: 'На главную',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
