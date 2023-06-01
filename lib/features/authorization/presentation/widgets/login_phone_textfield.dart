import 'package:flutter/material.dart';

import '../../../../styles/styles.dart';

class LoginPhoneTextField extends StatelessWidget {
  final ValueNotifier<bool> _isEmptyNotifier;
  final TextEditingController _phoneController;
  final FocusNode _phoneFieldFocusNode;
  const LoginPhoneTextField({
    super.key,
    required FocusNode phoneFieldFocusNode,
    required ValueNotifier<bool> isEmptyNotifier,
    required TextEditingController phoneController,
  })  : _isEmptyNotifier = isEmptyNotifier,
        _phoneController = phoneController,
        _phoneFieldFocusNode = phoneFieldFocusNode;

  void _clearTextField() {
    _phoneController.clear();
    if (!_phoneFieldFocusNode.hasPrimaryFocus) {
      _phoneFieldFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isEmptyNotifier,
      builder: (context, isEmpty, _) => TextField(
        controller: _phoneController,
        focusNode: _phoneFieldFocusNode,
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
                  onPressed: _clearTextField,
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
