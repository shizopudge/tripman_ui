import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/styles/styles.dart';

class DefaultTextField extends StatelessWidget {
  final bool? isEmpty;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final TextEditingController _controller;
  final FocusNode? _focusNode;
  final List<TextInputFormatter>? inputFormatters;
  const DefaultTextField({
    super.key,
    FocusNode? focusNode,
    required TextEditingController controller,
    this.isEmpty,
    this.onClear,
    this.onTap,
    this.isReadOnly = false,
    this.inputFormatters,
  })  : _controller = controller,
        _focusNode = focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      inputFormatters: inputFormatters,
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.phone,
      cursorColor: kBlack,
      cursorWidth: 1.0,
      cursorHeight: 16.0,
      style: kSFProDisplayRegular.copyWith(
        color: kBlack,
        fontSize: 16,
        height: 1,
      ),
      readOnly: isReadOnly,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        suffixIcon: isEmpty != null
            ? isEmpty!
                ? null
                : IconButton(
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
