import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/styles/styles.dart';
import '../buttons/rounded_text_button.dart';

class ConfirmationBanner extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String text;
  final String buttonText;
  final Color backgroundColor;
  const ConfirmationBanner({
    super.key,
    required this.iconPath,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16,
        ),
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: kBlack10,
            blurRadius: 2.5,
            spreadRadius: .5,
            offset: Offset(
              1,
              2,
            ),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              text,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: kSFProDisplayRegular.copyWith(
                fontSize: 15,
                color: kBlack,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            RoundedTextButton(
              isEnabled: true,
              onTap: onTap,
              text: buttonText,
            ),
          ],
        ),
      ),
    );
  }
}
