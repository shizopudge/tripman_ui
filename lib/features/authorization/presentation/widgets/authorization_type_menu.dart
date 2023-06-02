import 'package:flutter/material.dart';

import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import '../../../../core/styles/styles.dart';
import 'notice.dart';

class AuthTypeMenu extends StatelessWidget {
  final VoidCallback withPhone;
  final VoidCallback withGoogle;
  final VoidCallback withApple;
  const AuthTypeMenu({
    super.key,
    required this.withPhone,
    required this.withGoogle,
    required this.withApple,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimationYUp(
      delay: 2,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: RoundedRowIconButton(
                iconPath: 'assets/icons/phone.svg',
                text: 'Войти по номеру телефона',
                backgroundColor: kWhite,
                borderColor: kBlack.withOpacity(.2),
                textColor: kBlack,
                onTap: withPhone,
                verticalPadding: 13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: RoundedRowIconButton(
                iconPath: 'assets/icons/google.svg',
                text: 'Войти через Google',
                backgroundColor: kWhite,
                borderColor: kBlack.withOpacity(.2),
                textColor: kBlack,
                onTap: withGoogle,
                verticalPadding: 13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: RoundedRowIconButton(
                iconPath: 'assets/icons/apple.svg',
                text: 'Войти через Apple',
                backgroundColor: kBlack,
                borderColor: kBlack,
                textColor: kWhite,
                onTap: withApple,
                verticalPadding: 13,
              ),
            ),
            const Notice(),
          ],
        ),
      ),
    );
  }
}
