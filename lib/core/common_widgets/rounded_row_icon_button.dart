import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/styles.dart';

class RoundedRowIconButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final bool invertColor;
  final VoidCallback onTap;
  final double verticalPadding;
  const RoundedRowIconButton({
    super.key,
    required this.iconPath,
    required this.text,
    this.invertColor = false,
    required this.onTap,
    required this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: invertColor ? kBlack : Colors.transparent,
          border: Border.all(
            color: invertColor
                ? kBlack
                : kBlack.withOpacity(
                    .2,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: kSFProDisplayMedium.copyWith(
                color: invertColor ? kWhite : kBlack,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
