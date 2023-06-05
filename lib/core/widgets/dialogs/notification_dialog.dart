import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../animations/fade_animation_y_down.dart';
import '../../styles/styles.dart';
import '../buttons/rounded_text_button.dart';

class NotificationDialog extends StatelessWidget {
  final String title;
  final String description;
  const NotificationDialog({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimationYDown(
      delay: .4,
      child: SimpleDialog(
        backgroundColor: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimationYDown(
                    delay: .5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: kSFProDisplaySemiBold.copyWith(
                          fontSize: 24,
                          color: kBlack,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FadeAnimationYDown(
                    delay: .6,
                    child: Text(
                      description,
                      style: kSFProDisplayRegular.copyWith(
                        fontSize: 15,
                        color: kBlack50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FadeAnimationYDown(
                    delay: .7,
                    child: RoundedTextButton(
                      text: 'Отлично',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              FadeAnimationYDown(
                delay: .5,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6, top: 6),
                    child: SvgPicture.asset(
                      'assets/icons/close.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
