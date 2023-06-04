import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';
import '../../../../core/common_widgets/rounded_row_icon_button.dart';

class Distance extends StatelessWidget {
  final int distance;
  const Distance({
    super.key,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          right: 16,
        ),
        child: RoundedRowIconButton(
          mainAxisSize: MainAxisSize.min,
          iconPath: 'assets/icons/map_arrow.svg',
          text: '$distance км',
          onTap: () {},
          verticalPadding: 8,
          horizontalPadding: 8,
          backgroundColor: kWhite,
          borderColor: kWhite,
          inRowPadding: 6,
          textStyle: kSFProDisplayRegular.copyWith(
            color: kBlack,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
