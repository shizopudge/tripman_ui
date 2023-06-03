import 'package:flutter/material.dart';

import '../styles/styles.dart';

class BottomSheetDivider extends StatelessWidget {
  const BottomSheetDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: MediaQuery.of(context).size.width * .2,
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kWhite,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
