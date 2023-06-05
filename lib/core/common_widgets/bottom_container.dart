import 'package:flutter/material.dart';

import '../styles/styles.dart';
import 'rounded_text_button.dart';

class BottomContainer extends StatelessWidget {
  final Widget text;
  final RoundedTextButton button;
  const BottomContainer({
    super.key,
    required this.text,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: kBlack10,
            offset: Offset(
              2,
              -4,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: text,
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              flex: 3,
              child: button,
            ),
          ],
        ),
      ),
    );
  }
}
