import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final double height;
  final DecorationImage image;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;

  const ImageContainer({
    super.key,
    required this.height,
    required this.image,
    this.borderRadius,
    this.gradient,
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
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: gradient,
              ),
            )
          : const SizedBox(),
    );
  }
}
