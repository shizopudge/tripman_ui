import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final double height;
  final DecorationImage image;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final AlignmentGeometry? gradientAlignment;
  const ImageContainer({
    super.key,
    required this.height,
    required this.image,
    this.borderRadius,
    this.gradient,
    this.gradientAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: image,
      ),
      child: gradient != null
          ? Container(
              alignment: gradientAlignment ?? Alignment.topLeft,
              decoration: BoxDecoration(
                gradient: gradient,
              ),
            )
          : const SizedBox(),
    );
  }
}
