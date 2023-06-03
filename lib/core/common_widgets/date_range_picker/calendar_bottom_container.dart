import 'package:flutter/material.dart';

import '../../service/date_formater.dart';
import '../../styles/styles.dart';
import '../rounded_text_button.dart';

class CalendarBottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  final DateTimeRange? selectedDates;
  const CalendarBottomContainer({
    super.key,
    required this.onTap,
    this.selectedDates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                DateFormater.datesFieldDateFormater(
                  interval: selectedDates,
                ),
                overflow: TextOverflow.visible,
                style: kSFProDisplayMedium.copyWith(
                  fontSize: 16,
                  color: selectedDates != null ? kBlack : kBlack50,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              flex: 3,
              child: RoundedTextButton(
                backgroundColor: selectedDates != null ? kBlack : kBlack10,
                textColor: selectedDates != null ? kWhite : kBlack50,
                text: 'Забронировать',
                onTap: selectedDates != null ? onTap : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
