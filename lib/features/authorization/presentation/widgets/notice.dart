import 'package:flutter/material.dart';

import '../../../../styles/styles.dart';

class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'При входе на ресурс,\nвы принимаете условия доступа',
      textAlign: TextAlign.center,
      style: kSFProDisplayRegular.copyWith(
        fontSize: 14,
        color: kBlack,
      ),
    );
  }
}
