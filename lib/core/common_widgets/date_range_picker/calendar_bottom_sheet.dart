import 'package:flutter/material.dart';

import '../../animations/fade_animation_x.dart';
import '../../animations/fade_animation_y_down.dart';
import '../../styles/styles.dart';
import '../bottom_sheet_divider.dart';
import 'calendar.dart';

class CalendarBottomSheet extends StatelessWidget {
  final ValueNotifier<DateTimeRange?> _selectedDatesNotifier;
  const CalendarBottomSheet({
    super.key,
    required ValueNotifier<DateTimeRange?> selectedDatesNotifier,
  }) : _selectedDatesNotifier = selectedDatesNotifier;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .8,
      child: Column(
        children: [
          const FadeAnimationYDown(
            delay: 1,
            child: BottomSheetDivider(),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  FadeAnimationX(
                    delay: 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Даты поездки',
                        style: kSFProDisplaySemiBold.copyWith(
                          color: kBlack,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Calendar(
                      selectedDatesNotifier: _selectedDatesNotifier,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
