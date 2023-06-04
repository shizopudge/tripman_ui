import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/common_widgets/trip_images_carousel.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/styles/styles.dart';

class TripPage extends StatefulWidget {
  final Trip trip;
  final CarouselController _carouselController;
  final ValueNotifier<int> _currentImageNotifier;
  const TripPage({
    super.key,
    required this.trip,
    required CarouselController carouselController,
    required ValueNotifier<int> currentImageNotifier,
  })  : _carouselController = carouselController,
        _currentImageNotifier = currentImageNotifier;

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Hero(
                tag: widget.trip.id,
                child: TripImagesCarousel(
                  height: MediaQuery.of(context).size.height * .35,
                  controller: widget._carouselController,
                  currentImageNotifier: widget._currentImageNotifier,
                  images: widget.trip.images,
                  gradient: LinearGradient(
                    colors: [
                      kBlack.withOpacity(.4),
                      kBlack.withOpacity(.3),
                      kBlack.withOpacity(.2),
                    ],
                  ),
                ),
              ),
              FadeAnimationYDown(
                delay: 1,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  padding: const EdgeInsets.only(left: 25, top: 40),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kWhite,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
