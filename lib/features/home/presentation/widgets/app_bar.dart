import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/entities/trip_type.dart';
import '../../../../core/styles/styles.dart';
import 'interval_field.dart';
import 'trip_type_card.dart';

AppBar buildAppBar({
  required VoidCallback closeShowMenu,
  required VoidCallback showCalendar,
  required VoidCallback clear,
  required ValueNotifier<DateTimeRange?> selectedDatesNotifier,
  required ValueNotifier<TripType> selectedTripTypeNotifier,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 140,
    titleSpacing: 20,
    centerTitle: true,
    forceMaterialTransparency: true,
    elevation: 0,
    title: FadeAnimationYDown(
      delay: .2,
      child: ValueListenableBuilder(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, _) => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: IntervalField(
                    onTap: showCalendar,
                    clear: clear,
                    interval: selectedDates,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: closeShowMenu,
                  borderRadius: BorderRadius.circular(21),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: kBlack,
                    child: SvgPicture.asset(
                      'assets/icons/menu.svg',
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 72,
              width: double.infinity,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: tripTypes.length,
                  itemBuilder: (context, index) {
                    final TripType tripType = tripTypes[index];
                    return ValueListenableBuilder(
                      valueListenable: selectedTripTypeNotifier,
                      builder: (context, selectedTripType, _) => TripTypeCard(
                        onTap: () => selectedTripTypeNotifier.value = tripType,
                        isSelected: selectedTripTypeNotifier.value == tripType,
                        tripType: tripType,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
