import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/styles/styles.dart';

AppBar buildMenu(
  BuildContext context, {
  required VoidCallback closeShowMenu,
  required VoidCallback logout,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery.of(context).size.height * .25,
    forceMaterialTransparency: true,
    elevation: 0,
    flexibleSpace: FlexibleSpaceBar(
      background: FadeAnimationYDown(
        delay: .2,
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(
            top: 60,
            bottom: 24,
          ),
          decoration: const BoxDecoration(
            color: kBlack,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                20,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Меню',
                    style: kSFProDisplaySemiBold.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: closeShowMenu,
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      'assets/icons/close.svg',
                      colorFilter: const ColorFilter.mode(
                        kWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Объекты',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kSFProDisplaySemiBold.copyWith(
                  fontSize: 16,
                ),
              ),
              Text(
                'Добавить объекты',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kSFProDisplaySemiBold.copyWith(
                  fontSize: 16,
                ),
              ),
              InkWell(
                onTap: logout,
                child: Text(
                  'Выход',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kSFProDisplaySemiBold.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
