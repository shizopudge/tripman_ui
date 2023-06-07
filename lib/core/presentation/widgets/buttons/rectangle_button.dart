import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/styles.dart';

class RectangleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String text;
  const RectangleButton({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        20,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .13,
        width: MediaQuery.of(context).size.width * .265,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .01,
          vertical: MediaQuery.of(context).size.height * .005,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: kBlack.withOpacity(.2)),
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: kSFProDisplayRegular.copyWith(
                color: kBlack,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
