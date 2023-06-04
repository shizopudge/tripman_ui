import 'package:carousel_slider/carousel_controller.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/common_widgets/trip_images_carousel.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/styles/styles.dart';
import '../widgets/more_bottom_sheet.dart';

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
  void _showMore() => showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return MoreBottomSheet(
            description: widget.trip.description,
          );
        },
      );
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
                      kBlack.withOpacity(.35),
                      kBlack.withOpacity(.2),
                      kBlack.withOpacity(.1),
                    ],
                  ),
                ),
              ),
              FadeAnimationYDown(
                delay: .5,
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: FadeAnimationYDown(
                    delay: .6,
                    child: Text(
                      widget.trip.title,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      style: kSFProDisplaySemiBold.copyWith(
                        height: 1,
                        fontSize: 24,
                        color: kBlack,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FadeAnimationYDown(
                    delay: .7,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/map_arrow.svg',
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Flexible(
                          child: Text(
                            '${widget.trip.distance} км',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kSFProDisplayMedium.copyWith(
                              color: kBlack,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FadeAnimationYDown(
              delay: .8,
              child: ExpandableText(
                widget.trip.description,
                maxLines: 5,
                expandText: 'Подробнее',
                style: kSFProDisplayRegular.copyWith(
                  color: kBlack,
                  fontSize: 15,
                ),
                onLinkTap: _showMore,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kBlack50),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Column(children: []),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kBlack50),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kBlack50),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
