import 'package:flutter/material.dart';

import '../../../../core/common_widgets/bottom_sheet_divider.dart';
import '../../../../core/styles/styles.dart';

class MoreBottomSheet extends StatelessWidget {
  final String description;
  const MoreBottomSheet({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .65,
      child: Column(
        children: [
          const BottomSheetDivider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Подробнее',
                    style: kSFProDisplaySemiBold.copyWith(
                      color: kBlack,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    description,
                    style: kSFProDisplayRegular.copyWith(
                      color: kBlack,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
