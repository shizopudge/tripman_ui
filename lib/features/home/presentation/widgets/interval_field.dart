import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/service/date_formater.dart';
import '../../../../core/styles/styles.dart';

class IntervalField extends StatelessWidget {
  final DateTimeRange? interval;
  final VoidCallback onTap;
  final VoidCallback clear;
  const IntervalField({
    super.key,
    required this.interval,
    required this.onTap,
    required this.clear,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          DateFormater.datesFieldDateFormater(
                              interval: interval),
                          overflow: TextOverflow.ellipsis,
                          style: kSFProDisplayMedium.copyWith(
                            color: interval != null ? kBlack : kBlack50,
                            height: 1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (interval != null)
              InkWell(
                onTap: clear,
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
