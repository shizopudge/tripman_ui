import 'package:flutter/material.dart';

import '../../animations/fade_animation_y_down.dart';
import '../../constants/styles/styles.dart';
import '../buttons/close_button.dart';
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
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        insetPadding: const EdgeInsets.all(20),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      title,
                      overflow: TextOverflow.visible,
                      style: kSFProDisplaySemiBold.copyWith(
                        fontSize: 24,
                        color: kBlack,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: kSFProDisplayRegular.copyWith(
                      fontSize: 15,
                      color: kBlack50,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  RoundedTextButton(
                    text: 'Отлично',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const MyCloseButton(),
            ],
          ),
        ],
      ),
    );
  }
}
