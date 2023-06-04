import 'package:flutter/material.dart';

class TripImage extends StatelessWidget {
  final double height;
  final ImageProvider<Object> imageProvider;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final AlignmentGeometry? gradientAlignment;
  const TripImage({
    super.key,
    required this.height,
    required this.imageProvider,
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
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
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
