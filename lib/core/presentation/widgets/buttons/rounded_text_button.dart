import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class RoundedTextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isEnabled;
  final bool invertColors;
  const RoundedTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isEnabled = true,
    this.invertColors = false,
  });

  @override
  Widget build(BuildContext context) {
    if (invertColors) {
      return InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(
          100,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
          decoration: BoxDecoration(
            color: isEnabled ? kWhite : kBlack10,
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: kSFProDisplayMedium.copyWith(
                color: isEnabled ? kBlack : kBlack50,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(
          100,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
          decoration: BoxDecoration(
            color: isEnabled ? kBlack : kBlack10,
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: kSFProDisplayMedium.copyWith(
                color: isEnabled ? kWhite : kBlack50,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }
  }
}
