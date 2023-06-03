import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class IntervalPoint extends StatelessWidget {
  final String day;
  final BorderRadius? borderRadius;
  const IntervalPoint({
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
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          decoration: BoxDecoration(
            color: kBlack10,
            borderRadius: borderRadius,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                fontSize: MediaQuery.of(context).size.width / 100 * 3.25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
