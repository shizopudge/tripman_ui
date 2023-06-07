import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/date_format_util.dart';
import '../../../../core/styles/styles.dart';

class SelectedIntervalField extends StatelessWidget {
  final DateTimeRange? interval;
  final VoidCallback onTap;
  final VoidCallback clear;
  const SelectedIntervalField({
    super.key,
    required this.interval,
    required this.onTap,
    required this.clear,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: kBlack.withOpacity(.2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: interval != null
                            ? Text(
                                DateFormatUtil.dateRange(
                                    interval: interval!, withYear: true),
                                overflow: TextOverflow.ellipsis,
                                style: kSFProDisplayMedium.copyWith(
                                  color: interval != null ? kBlack : kBlack50,
                                  height: 1,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                'Даты поездки',
                                overflow: TextOverflow.ellipsis,
                                style: kSFProDisplayMedium.copyWith(
                                  color: kBlack50,
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
            if (interval != null)
              IconButton(
                onPressed: clear,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                icon: SvgPicture.asset(
                  'assets/icons/close.svg',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
