import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../entities/trip_type.dart';
import '../../constants/styles/styles.dart';

class TripTypeCard extends StatelessWidget {
  final TripType tripType;
  final bool isSelected;
  final VoidCallback onTap;
  const TripTypeCard({
    super.key,
    required this.tripType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        8,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 72,
        constraints: const BoxConstraints(minWidth: 78),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? kBlack10 : null,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              tripType.image,
              colorFilter: ColorFilter.mode(
                isSelected ? kBlack : kBlack50,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              tripType.title,
              style: kSFProDisplayRegular.copyWith(
                color: isSelected ? kBlack : kBlack50,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
