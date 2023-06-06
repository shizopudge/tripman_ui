import 'package:flutter/material.dart';

import '../../animations/fade_animation_y_down.dart';
import '../../constants/styles/styles.dart';
import '../buttons/close_button.dart';
import 'bottom_sheet_divider.dart';

class ScaffoldBottomSheet extends StatelessWidget {
  final Widget child;
  final Color color;
  final String title;
  final bool withCloseIcon;
  const ScaffoldBottomSheet({
    super.key,
    required this.child,
    this.color = kWhite,
    required this.title,
    this.withCloseIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetDivider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  if (withCloseIcon)
                    FadeAnimationYDown(
                      delay: .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: kSFProDisplaySemiBold.copyWith(
                              color: kBlack,
                              fontSize: 24,
                            ),
                          ),
                          const MyCloseButton(),
                        ],
                      ),
                    )
                  else
                    FadeAnimationYDown(
                      delay: .5,
                      child: Text(
                        title,
                        style: kSFProDisplaySemiBold.copyWith(
                          color: kBlack,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  child,
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
