import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tripman/core/widgets/images/image_cached.dart';

import '../../constants/styles/styles.dart';

class ImagesCarousel extends StatelessWidget {
  final double height;
  final List<String> images;
  final CarouselController _controller;
  final ValueNotifier<int> _currentImageNotifier;
  final BorderRadius? imagesBorderRadius;
  final LinearGradient? gradient;
  final BoxFit? fit;
  const ImagesCarousel({
    super.key,
    required this.images,
    required this.height,
    this.imagesBorderRadius,
    this.gradient,
    this.fit,
    required CarouselController controller,
    required ValueNotifier<int> currentImageNotifier,
  })  : _controller = controller,
        _currentImageNotifier = currentImageNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentImageNotifier,
      builder: (context, currentImage, _) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            carouselController: _controller,
            items: images
                .map(
                  (image) => ImageCached(
                    imageUrl: image,
                    height: height,
                    borderRadius: imagesBorderRadius,
                    gradient: gradient,
                    fit: fit,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              autoPlayCurve: Curves.easeOut,
              autoPlay: true,
              initialPage: currentImage,
              onPageChanged: (index, reason) =>
                  _currentImageNotifier.value = index,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images
                    .asMap()
                    .entries
                    .map(
                      (entry) => GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: currentImage == entry.key
                              ? 8
                              : entry.key == 0 || entry.key == images.length - 1
                                  ? 3
                                  : 6,
                          width: currentImage == entry.key
                              ? 8
                              : entry.key == 0 || entry.key == images.length - 1
                                  ? 3
                                  : 6,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentImage == entry.key
                                ? kWhite
                                : kWhite.withOpacity(
                                    .5,
                                  ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
