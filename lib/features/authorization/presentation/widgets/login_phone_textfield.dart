import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class LoginPhoneTextField extends StatelessWidget {
  final bool isEmpty;
  final VoidCallback onClear;
  final TextEditingController _phoneController;
  final FocusNode _phoneFieldFocusNode;
  const LoginPhoneTextField({
    super.key,
    required FocusNode phoneFieldFocusNode,
    required TextEditingController phoneController,
    required this.isEmpty,
    required this.onClear,
  })  : _phoneController = phoneController,
        _phoneFieldFocusNode = phoneFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
                onPressed: onClear,
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
    );
  }
}
