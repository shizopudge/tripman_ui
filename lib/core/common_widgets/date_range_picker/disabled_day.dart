import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class DisabledDay extends StatelessWidget {
  final String day;
  const DisabledDay({
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
          fontSize: MediaQuery.of(context).size.width / 100 * 3.25,
        ),
      ),
    );
  }
}
