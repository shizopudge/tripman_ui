import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common_widgets/rounded_row_icon_button.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/service/date_formater.dart';
import '../../../../core/styles/styles.dart';
import '../../../trip/presentation/pages/trip_page.dart';
import '../../../../core/common_widgets/trip_images_carousel.dart';

class TripCard extends StatefulWidget {
  final Trip trip;
  const TripCard({
    super.key,
    required this.trip,
  });

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  late final CarouselController _carouselController;
  late final ValueNotifier<int> _currentImageNotifier;
  @override
  void initState() {
    _carouselController = CarouselController();
    _currentImageNotifier = ValueNotifier<int>(0);
    super.initState();
  }

  void _navigateToTripPage(
          {required BuildContext context, required Trip trip}) =>
      Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.fade,
          child: TripPage(
            trip: trip,
            carouselController: _carouselController,
            currentImageNotifier: _currentImageNotifier,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToTripPage(context: context, trip: widget.trip),
      child: Container(
        height: 451,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(.1),
              blurRadius: 5.0,
              spreadRadius: 1.5,
              offset: const Offset(1.5, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.trip.id,
                  child: TripImagesCarousel(
                    height: 335,
                    controller: _carouselController,
                    currentImageNotifier: _currentImageNotifier,
                    images: widget.trip.images,
                    imagesBorderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.trip.title,
                        overflow: TextOverflow.ellipsis,
                        style: kSFProDisplaySemiBold.copyWith(
                          color: kBlack,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'от ${widget.trip.minCost} ₽',
                              overflow: TextOverflow.ellipsis,
                              style: kSFProDisplayMedium.copyWith(
                                fontSize: 16,
                                color: kBlack,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormater.tripCardDateFormater(
                                    interval: widget.trip.interval,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  style: kSFProDisplayRegular.copyWith(
                                    color: kBlack50,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '${widget.trip.minMembersCount}-${widget.trip.maxMembersCount} гостей',
                                  overflow: TextOverflow.ellipsis,
                                  style: kSFProDisplayRegular.copyWith(
                                    color: kBlack50,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 16,
                ),
                child: RoundedRowIconButton(
                  mainAxisSize: MainAxisSize.min,
                  iconPath: 'assets/icons/map_arrow.svg',
                  text: '${widget.trip.distance} км',
                  onTap: () {},
                  verticalPadding: 8,
                  horizontalPadding: 8,
                  backgroundColor: kWhite,
                  borderColor: kWhite,
                  inRowPadding: 6,
                  textStyle: kSFProDisplayRegular.copyWith(
                    color: kBlack,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
