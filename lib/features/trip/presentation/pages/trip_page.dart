import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/animations/fade_animation_x.dart';
import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/widgets/common/bottom_container.dart';
import '../../../../core/widgets/bottom_sheet/sized_bottom_sheet.dart';
import '../../../../core/widgets/calendar/calendar.dart';
import '../../../../core/widgets/buttons/rounded_text_button.dart';
import '../../../../core/widgets/dialogs/notification_dialog.dart';
import '../../../../core/widgets/images/images_carousel.dart';
import '../../../../core/widgets/dialogs/review_dialog.dart';
import '../../../../core/entities/trip.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/buttons/rectangle_button.dart';
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
  late final ValueNotifier<bool> _isErrorNotifier;

  @override
  void initState() {
    _selectedIntervalNotifier = ValueNotifier<DateTimeRange?>(null)
      ..addListener(_selectedIntervalListener);
    _isRequestSentNotifier = ValueNotifier<bool>(false)
      ..addListener(_isRequestSentListener);
    _isErrorNotifier =
        ValueNotifier<bool>(widget.trip.id == '2' ? true : false);
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
          builder: (context) => const NotificationDialog(
            title: 'Ваша заявка успешно отправлена',
            description: 'Бронирование будет подтверждено\nв течении 24 часов',
          ),
        ).whenComplete(
          () async {
            _isRequestSentNotifier.value = false;
            await showDialog(
              context: context,
              builder: (context) => const ReviewDialog(),
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
          return SizedBottomSheet(
            heightFactor: .65,
            title: 'Подробнее',
            child: Text(
              widget.trip.description,
              style: kSFProDisplayRegular.copyWith(
                color: kBlack,
                fontSize: 15,
              ),
            ),
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
        return SizedBottomSheet(
          heightFactor: .8,
          title: 'Даты поездки',
          isScrollable: false,
          child: Calendar(
            selectedIntervalNotifier: _selectedIntervalNotifier,
            availableRange: widget.trip.interval,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _isErrorNotifier,
        builder: (context, isError, _) {
          if (isError) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeAnimationYDown(
                    delay: .5,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 25, top: 20),
                        child: Icon(
                          Icons.arrow_back,
                          color: kBlack,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Объект удалён или не найден.',
                      style: kSFProDisplayRegular.copyWith(
                        color: kBlack50,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  FadeAnimationYUp(
                    delay: 1.2,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: kBlack10,
                            offset: Offset(
                              2,
                              -4,
                            ),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: RoundedTextButton(
                          text: 'На главную',
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Hero(
                      tag: widget.trip.id,
                      child: ImagesCarousel(
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
                        gradientAlignment: Alignment.topLeft,
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
                            child: RectangleButton(
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
                            child: RectangleButton(
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
                            child: RectangleButton(
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
                  child: BottomShadowContainer(
                    left: Column(
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
                    right: RoundedTextButton(
                      text: 'Свободные даты',
                      onTap: _showCalendar,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
