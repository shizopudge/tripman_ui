import 'package:flutter/material.dart';

import '../../../../core/common_widgets/rounded_text_button.dart';
import '../../../../styles/styles.dart';

class LoginConfirmPhoneButton extends StatelessWidget {
  final ValueNotifier<bool> _isValidatedNotifier;
  final VoidCallback onTap;
  const LoginConfirmPhoneButton({
    super.key,
    required ValueNotifier<bool> isValidatedNotifier,
    required this.onTap,
  }) : _isValidatedNotifier = isValidatedNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isValidatedNotifier,
      builder: (context, isValidated, _) => RoundedTextButton(
        onTap: isValidated ? onTap : null,
        backgroundColor: isValidated ? kBlack : kBlack10,
        textColor: isValidated ? kWhite : kBlack50,
        text: 'Подтвердить номер',
      ),
    );
  }
}
