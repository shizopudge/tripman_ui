import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';
import 'notice_bottom_sheet.dart';

class Notice extends StatelessWidget {
  const Notice({super.key});

  void onTap(BuildContext context) => showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const NoticeBottomSheet();
        },
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Text(
        'При входе на ресурс,\nвы принимаете условия доступа',
        textAlign: TextAlign.center,
        style: kSFProDisplayRegular.copyWith(
          fontSize: 14,
          color: kBlack,
        ),
      ),
    );
  }
}
