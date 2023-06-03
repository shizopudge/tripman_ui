import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/service/date_formater.dart';
import '../../../../core/styles/styles.dart';

class DatesField extends StatelessWidget {
  final DateTimeRange? interval;
  final VoidCallback onTap;
  final VoidCallback onClear;
  const DatesField({
    super.key,
    required this.interval,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: interval == null ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: kBlack.withOpacity(.2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: interval == null ? null : onTap,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Text(
                        DateFormater.datesFieldDateFormater(interval: interval),
                        overflow: TextOverflow.ellipsis,
                        style: kSFProDisplayMedium.copyWith(
                          color: interval != null ? kBlack : kBlack50,
                          height: 1,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (interval != null)
              InkWell(
                onTap: onClear,
                child: SvgPicture.asset(
                  'assets/icons/close.svg',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
