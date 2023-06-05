import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      icon: SvgPicture.asset(
        'assets/icons/close.svg',
      ),
    );
  }
}
