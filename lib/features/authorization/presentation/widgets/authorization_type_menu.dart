import 'package:flutter/material.dart';

import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import 'notice.dart';

class AuthorizationTypeMenu extends StatelessWidget {
  final VoidCallback withPhone;
  final VoidCallback withGoogle;
  final VoidCallback withApple;
  final ValueNotifier<double> _opacityNotifier;
  const AuthorizationTypeMenu({
    super.key,
    required this.withPhone,
    required this.withGoogle,
    required this.withApple,
    required ValueNotifier<double> opacityNotifier,
  }) : _opacityNotifier = opacityNotifier;

  @override
  Widget build(BuildContext context) {
    return FadeAnimationYUp(
      delay: 2,
      child: ValueListenableBuilder(
        valueListenable: _opacityNotifier,
        builder: (context, opacity, child) => AnimatedOpacity(
          curve: Curves.easeOut,
          opacity: opacity,
          duration: const Duration(milliseconds: 250),
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
                    invertColor: true,
                    onTap: withApple,
                    verticalPadding: 13,
                  ),
                ),
                const Notice(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
