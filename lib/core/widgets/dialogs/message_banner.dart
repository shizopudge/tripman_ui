import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/styles/styles.dart';
import '../buttons/rounded_text_button.dart';

class MessageBanner extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color backgroundColor;
  const MessageBanner({
    super.key,
    required this.iconPath,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16,
        ),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.visible,
                  style: kSFProDisplayRegular.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          RoundedTextButton(
            isEnabled: true,
            onTap: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
            text: 'Кнопка',
            invertColors: true,
          ),
        ],
      ),
    );
  }
}
