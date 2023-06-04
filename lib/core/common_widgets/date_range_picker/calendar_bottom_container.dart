import 'package:flutter/material.dart';

import '../../service/date_formater.dart';
import '../../styles/styles.dart';
import '../rounded_text_button.dart';

class CalendarBottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  final DateTimeRange? selectedInterval;
  const CalendarBottomContainer({
    super.key,
    required this.onTap,
    this.selectedInterval,
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
                  interval: selectedInterval,
                ),
                overflow: TextOverflow.visible,
                style: kSFProDisplayMedium.copyWith(
                  fontSize: 16,
                  color: selectedInterval != null ? kBlack : kBlack50,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              flex: 3,
              child: RoundedTextButton(
                backgroundColor: selectedInterval != null ? kBlack : kBlack10,
                textColor: selectedInterval != null ? kWhite : kBlack50,
                text: 'Забронировать',
                onTap: selectedInterval != null ? onTap : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
