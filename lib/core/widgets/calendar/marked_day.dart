import 'package:flutter/material.dart';

import '../../constants/styles/styles.dart';

class MarkedDay extends StatelessWidget {
  final String day;
  final bool isStart;
  final bool isEqual;
  final bool isOnEdge;
  const MarkedDay({
    super.key,
    required this.day,
    required this.isStart,
    required this.isEqual,
    required this.isOnEdge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (!isEqual && !isOnEdge)
          Container(
            decoration: BoxDecoration(
              color: kBlack10,
              borderRadius: isStart
                  ? const BorderRadius.horizontal(
                      left: Radius.circular(100),
                    )
                  : const BorderRadius.horizontal(
                      right: Radius.circular(100),
                    ),
            ),
          ),
        Container(
          height: double.maxFinite,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kBlack,
          ),
          child: Center(
            child: Text(
              day,
              style: kSFProDisplayRegular.copyWith(
                color: kWhite,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
