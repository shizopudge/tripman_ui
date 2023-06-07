import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/styles/styles.dart';

class SmsCodeInput extends StatelessWidget {
  final bool isIncorrectCode;
  final EdgeInsets padding;
  final FocusNode _codeFocus;
  final TextEditingController _codeController;
  const SmsCodeInput({
    super.key,
    required FocusNode codeFocus,
    required TextEditingController codeController,
    required this.isIncorrectCode,
    required this.padding,
  })  : _codeFocus = codeFocus,
        _codeController = codeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Pinput(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            focusNode: _codeFocus,
            controller: _codeController,
            showCursor: false,
            length: 4,
            closeKeyboardWhenCompleted: false,
            forceErrorState: isIncorrectCode,
            defaultPinTheme: PinTheme(
              height: 8,
              width: 8,
              textStyle: kSFProDisplaySemiBold.copyWith(
                color: kBlack.withOpacity(
                  .2,
                ),
                height: 1,
                fontSize: 45,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBlack.withOpacity(
                  .2,
                ),
              ),
            ),
            focusedPinTheme: PinTheme(
              height: 12,
              width: 12,
              textStyle: kSFProDisplaySemiBold.copyWith(
                color: kBlack,
                height: 1,
                fontSize: 45,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kBlack,
              ),
            ),
            submittedPinTheme: PinTheme(
              textStyle: kSFProDisplaySemiBold.copyWith(
                color: kBlack,
                height: 1,
                fontSize: 45,
              ),
            ),
            errorPinTheme: PinTheme(
              textStyle: kSFProDisplaySemiBold.copyWith(
                color: kRed,
                height: 1,
                fontSize: 45,
              ),
            ),
          ),
          if (isIncorrectCode)
            const SizedBox(
              height: 9,
            ),
          if (isIncorrectCode)
            Text(
              'Не верный код',
              style: kSFProDisplayRegular.copyWith(
                color: kRed,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
