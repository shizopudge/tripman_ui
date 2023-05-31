import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class RoundedTextButton extends StatelessWidget {
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final String text;
  final VoidCallback? onTap;
  const RoundedTextButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        100,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            100,
          ),
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                )
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: kSFProDisplayMedium.copyWith(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
