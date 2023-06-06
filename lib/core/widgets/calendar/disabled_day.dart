import 'package:flutter/material.dart';

import '../../constants/styles/styles.dart';

class UnavailableDay extends StatelessWidget {
  final String day;
  const UnavailableDay({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        day,
        style: kSFProDisplayRegular.copyWith(
          color: kBlack.withOpacity(.2),
          fontSize: 16,
        ),
      ),
    );
  }
}
