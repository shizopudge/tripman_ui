import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class RequestTextRow extends StatelessWidget {
  final String title;
  final String info;
  const RequestTextRow({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kSFProDisplayRegular.copyWith(
            color: kBlack50,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Text(
            info,
            overflow: TextOverflow.visible,
            style: kSFProDisplayRegular.copyWith(
              fontSize: 15,
              color: kBlack,
            ),
          ),
        ),
      ],
    );
  }
}
