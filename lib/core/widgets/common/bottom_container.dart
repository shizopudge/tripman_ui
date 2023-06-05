import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class BottomShadowContainer extends StatelessWidget {
  final Widget left;
  final Widget right;
  const BottomShadowContainer({
    super.key,
    required this.left,
    required this.right,
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
              child: left,
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              flex: 3,
              child: right,
            ),
          ],
        ),
      ),
    );
  }
}
