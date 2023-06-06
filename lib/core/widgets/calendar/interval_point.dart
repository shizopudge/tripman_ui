import 'package:flutter/material.dart';

import '../../constants/styles/styles.dart';

class IntervaledDay extends StatelessWidget {
  final String day;
  final BorderRadius? borderRadius;
  const IntervaledDay({
    super.key,
    required this.day,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: kBlack10,
            borderRadius: borderRadius,
          ),
        ),
        Container(
          height: double.maxFinite,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kBlack10,
          ),
          child: Center(
            child: Text(
              day,
              style: kSFProDisplayRegular.copyWith(
                color: kBlack,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
