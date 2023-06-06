import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'image_container.dart';
import 'image_placeholder.dart';

class ImageCached extends StatelessWidget {
  final String imageUrl;
  final double height;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final BoxFit? fit;
  const ImageCached({
    super.key,
    required this.imageUrl,
    required this.height,
    this.borderRadius,
    this.gradient,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => ImageContainer(
        height: height,
        image: DecorationImage(
          image: imageProvider,
          fit: fit ?? BoxFit.cover,
        ),
        borderRadius: borderRadius,
        gradient: gradient,
      ),
      placeholder: (context, url) => ImagePlaceholder(
        height: height,
        borderRadius: borderRadius,
      ),
      errorWidget: (context, url, error) => ImagePlaceholder(
        height: height,
        borderRadius: borderRadius,
      ),
    );
  }
}
