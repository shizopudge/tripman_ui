import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/animations/fade_animation_x.dart';
import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/bottom_container.dart';
import '../../../../core/common_widgets/date_range_picker/calendar_bottom_sheet.dart';
import '../../../../core/common_widgets/rounded_text_button.dart';
import '../../../../core/common_widgets/trip_message_dialog.dart';
import '../../../../core/common_widgets/trip_images_carousel.dart';
import '../../../../core/common_widgets/trip_review_dialog.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/styles/styles.dart';
import '../widgets/more_bottom_sheet.dart';
import '../widgets/trip_action_button.dart';
import 'request_page.dart';

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
  late final ValueNotifier<DateTimeRange?> _selectedIntervalNotifier;
  late final ValueNotifier<bool> _isRequestSentNotifier;

  @override
  void initState() {
    _selectedIntervalNotifier = ValueNotifier<DateTimeRange?>(null)
      ..addListener(_selectedIntervalListener);
    _isRequestSentNotifier = ValueNotifier<bool>(false)
      ..addListener(_isRequestSentListener);
    super.initState();
  }

  @override
  void dispose() {
    _selectedIntervalNotifier.dispose();
    _isRequestSentNotifier.dispose();
    super.dispose();
  }

  void _selectedIntervalListener() {
    if (_selectedIntervalNotifier.value != null) {
      Future.delayed(
        Duration.zero,
        () => Navigator.of(context).push(
          PageTransition(
            duration: const Duration(milliseconds: 250),
            type: PageTransitionType.fade,
            child: RequestPage(
              trip: widget.trip,
              selectedInterval: _selectedIntervalNotifier.value!,
              isRequestSentNotifier: _isRequestSentNotifier,
            ),
          ),
        ),
      );
    }
  }

  void _isRequestSentListener() {
    if (_isRequestSentNotifier.value == true) {
      Future.delayed(
        Duration.zero,
        () async => await showDialog(
          context: context,
          builder: (context) => const TripMessageDialog(
            title: 'Ваша заявка успешно отправлена',
            description: 'Бронирование будет подтверждено\nв течении 24 часов',
          ),
        ).whenComplete(
          () async {
            _isRequestSentNotifier.value = false;
            await showDialog(
              context: context,
              builder: (context) => const TripReviewDialog(),
            );
          },
        ),
      );
    }
  }

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

  void _showCalendar() {
    _selectedIntervalNotifier.value = null;
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CalendarBottomSheet(
          selectedIntervalNotifier: _selectedIntervalNotifier,
          availableRange: widget.trip.interval,
        );
      },
    );
  }

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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FadeAnimationYDown(
                    delay: .8,
                    child: Text(
                      widget.trip.locationName,
                      overflow: TextOverflow.visible,
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack50,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FadeAnimationYDown(
                    delay: .8,
                    child: Text(
                      widget.trip.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack50,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FadeAnimationYDown(
                    delay: .8,
                    child: GestureDetector(
                      onTap: _showMore,
                      child: Text(
                        'Подробнее',
                        overflow: TextOverflow.ellipsis,
                        style: kSFProDisplayMedium.copyWith(
                          color: kBlack,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeAnimationX(
                      delay: .7,
                      child: TripActionButton(
                        onTap: () {},
                        iconPath: 'assets/icons/phone.svg',
                        text: 'Позвонить',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FadeAnimationX(
                      delay: .8,
                      child: TripActionButton(
                        onTap: () {},
                        iconPath: 'assets/icons/message.svg',
                        text: 'Написать',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FadeAnimationX(
                      delay: .9,
                      child: TripActionButton(
                        onTap: () {},
                        iconPath: 'assets/icons/share.svg',
                        text: 'Поделиться',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FadeAnimationYUp(
            delay: 1,
            child: BottomContainer(
              text: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.trip.minMembersCount}-${widget.trip.maxMembersCount} гостей',
                    style: kSFProDisplayRegular.copyWith(
                      color: kBlack50,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${widget.trip.minCost} ₽ / сутки',
                    style: kSFProDisplayMedium.copyWith(
                      color: kBlack,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              button: RoundedTextButton(
                backgroundColor: kBlack,
                textColor: kWhite,
                text: 'Свободные даты',
                onTap: _showCalendar,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
