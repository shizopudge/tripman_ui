import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/navigation_utils.dart';
import '../buttons/rounded_border_button.dart';
import '../../entities/trip.dart';
import '../../utils/date_format_util.dart';
import '../../constants/styles/styles.dart';
import '../../../features/trip/presentation/pages/trip_page.dart';
import '../images/images_carousel.dart';

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

  void _navigateToTripPage() => NavigationUtils.pushWithFade(
        context: context,
        page: TripPage(
          trip: widget.trip,
          carouselController: _carouselController,
          currentImageNotifier: _currentImageNotifier,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToTripPage,
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
                  child: ImagesCarousel(
                    height: 335,
                    controller: _carouselController,
                    currentImageNotifier: _currentImageNotifier,
                    images: widget.trip.images,
                    imagesBorderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        20,
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [
                        kBlack.withOpacity(.4),
                        kBlack.withOpacity(.2),
                      ],
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
                                  DateFormatUtil.dateRange(
                                    interval: widget.trip.interval,
                                    dublicateSameMonth: true,
                                    spacer: ' ',
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
              child: RoundedBorderButton(
                onTap: () {},
                mainAxisSize: MainAxisSize.min,
                backgroundColor: kWhite,
                borderColor: kWhite,
                horizontalPadding: 8,
                verticalPadding: 6,
                margin: const EdgeInsets.only(right: 16, top: 16),
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
                      overflow: TextOverflow.ellipsis,
                      style: kSFProDisplayRegular.copyWith(
                        fontSize: 15,
                        color: kBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
