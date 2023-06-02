import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/styles.dart';

class DatesField extends StatelessWidget {
  final String? interval;
  final VoidCallback onTap;
  const DatesField({
    super.key,
    required this.interval,
    required this.onTap,
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
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  height: 18,
                  width: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  interval ?? 'Даты поездки',
                  style: kSFProDisplayMedium.copyWith(
                    color: interval != null ? kBlack : kBlack50,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            if (interval != null)
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(21),
                child: SvgPicture.asset(
                  'assets/icons/close.svg',
                  height: 12,
                  width: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
