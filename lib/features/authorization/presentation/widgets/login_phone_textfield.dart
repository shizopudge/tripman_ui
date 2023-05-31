import 'package:flutter/material.dart';

import '../../../../styles/styles.dart';

class LoginPhoneTextField extends StatelessWidget {
  const LoginPhoneTextField({
    super.key,
    required ValueNotifier<bool> isEmptyNotifier,
    required TextEditingController phoneController,
  })  : _isEmptyNotifier = isEmptyNotifier,
        _phoneController = phoneController;

  final ValueNotifier<bool> _isEmptyNotifier;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isEmptyNotifier,
      builder: (context, isEmpty, _) => TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        cursorColor: kBlack,
        cursorWidth: 1.0,
        cursorHeight: 16.0,
        style: kSFProDisplayRegular.copyWith(
          color: kBlack,
          fontSize: 16,
          height: 1,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          suffixIcon: !isEmpty
              ? IconButton(
                  onPressed: () => _phoneController.clear(),
                  icon: const Icon(
                    Icons.close,
                    color: kBlack,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: const BorderSide(
              color: kBlack,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: const BorderSide(
              color: kBlack,
            ),
          ),
        ),
      ),
    );
  }
}
