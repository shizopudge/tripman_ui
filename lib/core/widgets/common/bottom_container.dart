import 'package:flutter/material.dart';

import '../../constants/styles/styles.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 16),
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
    );
  }
}
