import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedRowIconButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final double verticalPadding;
  final double horizontalPadding;
  final double inRowPadding;
  final TextStyle textStyle;
  final MainAxisSize mainAxisSize;
  const RoundedRowIconButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    required this.verticalPadding,
    this.horizontalPadding = 0,
    required this.backgroundColor,
    required this.borderColor,
    this.inRowPadding = 15,
    required this.textStyle,
    this.mainAxisSize = MainAxisSize.max,
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
          mainAxisSize: mainAxisSize,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            SizedBox(
              width: inRowPadding,
            ),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
