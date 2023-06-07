import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/styles.dart';
import '../../../../core/presentation/widgets/buttons/rounded_border_button.dart';
import '../../../../core/presentation/widgets/text/notice.dart';

class AuthTypeMenu extends StatelessWidget {
  final VoidCallback withPhone;
  final VoidCallback withGoogle;
  final VoidCallback withApple;
  const AuthTypeMenu({
    super.key,
    required this.withPhone,
    required this.withGoogle,
    required this.withApple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          RoundedBorderButton(
            onTap: withPhone,
            borderColor: kBlack.withOpacity(.2),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            children: [
              SvgPicture.asset(
                'assets/icons/phone.svg',
              ),
              const SizedBox(
                width: 14,
              ),
              Flexible(
                child: Text(
                  'Войти по номеру телефона',
                  overflow: TextOverflow.ellipsis,
                  style: kSFProDisplayMedium.copyWith(
                    fontSize: 16,
                    color: kBlack,
                  ),
                ),
              ),
            ],
          ),
          RoundedBorderButton(
            onTap: withGoogle,
            borderColor: kBlack.withOpacity(.2),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            children: [
              SvgPicture.asset(
                'assets/icons/google.svg',
              ),
              const SizedBox(
                width: 14,
              ),
              Flexible(
                child: Text(
                  'Войти через Google',
                  overflow: TextOverflow.ellipsis,
                  style: kSFProDisplayMedium.copyWith(
                    fontSize: 16,
                    color: kBlack,
                  ),
                ),
              ),
            ],
          ),
          RoundedBorderButton(
            onTap: withApple,
            backgroundColor: kBlack,
            borderColor: kBlack,
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            children: [
              SvgPicture.asset(
                'assets/icons/apple.svg',
              ),
              const SizedBox(
                width: 14,
              ),
              Flexible(
                child: Text(
                  'Войти через Apple',
                  overflow: TextOverflow.ellipsis,
                  style: kSFProDisplayMedium.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const Notice(),
        ],
      ),
    );
  }
}
