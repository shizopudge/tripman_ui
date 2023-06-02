import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/styles.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String iconPath;
  final String message;
  final Color? color;
  const ErrorMessageWidget({
    super.key,
    required this.message,
    required this.iconPath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: kSFProDisplayRegular.copyWith(
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
  }
}
