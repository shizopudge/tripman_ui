import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/entities/trip_type.dart';
import '../../../../core/styles/styles.dart';
import 'dates_field.dart';
import 'trip_type_card.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onDatesFieldTap;
  final VoidCallback onClear;
  final DateTimeRange? interval;
  final ValueNotifier<TripType> _selectedTripTypeNotifier;
  const HomeAppBar({
    super.key,
    required ValueNotifier<TripType> selectedTripTypeNotifier,
    required this.onDatesFieldTap,
    required this.interval,
    required this.onClear,
  }) : _selectedTripTypeNotifier = selectedTripTypeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DatesField(
                onTap: onDatesFieldTap,
                onClear: onClear,
                interval: interval,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {},
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
                  valueListenable: _selectedTripTypeNotifier,
                  builder: (context, selectedTripType, _) => TripTypeCard(
                    onTap: () => _selectedTripTypeNotifier.value = tripType,
                    isSelected: _selectedTripTypeNotifier.value == tripType,
                    tripType: tripType,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
