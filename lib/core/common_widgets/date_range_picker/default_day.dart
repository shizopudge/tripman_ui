import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class DefaultDay extends StatelessWidget {
  final String day;
  const DefaultDay({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      height: double.maxFinite,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          day,
          style: kSFProDisplayRegular.copyWith(
            color: kBlack,
            fontSize: MediaQuery.of(context).size.width / 100 * 3.25,
          ),
        ),
      ),
    );
  }
}