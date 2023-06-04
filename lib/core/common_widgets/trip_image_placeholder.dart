import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/styles/styles.dart';

class TripImagePlaceholder extends StatelessWidget {
  final double height;
  final BorderRadius? borderRadius;
  const TripImagePlaceholder({
    super.key,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kBlack10,
      highlightColor: kWhite,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBlack10,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
