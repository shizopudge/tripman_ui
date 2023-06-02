import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/styles.dart';

class RoundedRowIconButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;
  final double verticalPadding;
  final double horizontalPadding;
  final double inRowPadding;
  const RoundedRowIconButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    required this.verticalPadding,
    this.horizontalPadding = 0,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.inRowPadding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            SizedBox(
              width: inRowPadding,
            ),
            Text(
              text,
              style: kSFProDisplayMedium.copyWith(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
