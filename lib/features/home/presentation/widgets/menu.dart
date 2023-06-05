import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/common_widgets/error_screen.dart';
import '../../../../core/common_widgets/trip_message_dialog.dart';
import '../../../../core/styles/styles.dart';

AppBar buildMenu(
  BuildContext context, {
  required VoidCallback closeShowMenu,
  required VoidCallback logout,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery.of(context).size.height * .28,
    forceMaterialTransparency: true,
    elevation: 0,
    flexibleSpace: FlexibleSpaceBar(
      background: FadeAnimationYDown(
        delay: 0,
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(
            top: 40,
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
                      fontSize: MediaQuery.of(context).size.width / 100 * 4.5,
                    ),
                  ),
                  IconButton(
                    onPressed: closeShowMenu,
                    icon: SvgPicture.asset(
                      'assets/icons/close.svg',
                      colorFilter: const ColorFilter.mode(
                        kWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  PageTransition(
                    duration: const Duration(milliseconds: 250),
                    type: PageTransitionType.fade,
                    child: const ErrorScreen(),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Объекты',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kSFProDisplaySemiBold.copyWith(
                        fontSize: MediaQuery.of(context).size.width / 100 * 4,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async => await showDialog(
                  context: context,
                  builder: (context) => const TripMessageDialog(
                    title: 'Объект добавлен, ожидайте модерации. ',
                    description: 'Время модерациив среднем\nзанимает 2-3 часа',
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Добавить объекты',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kSFProDisplaySemiBold.copyWith(
                        fontSize: MediaQuery.of(context).size.width / 100 * 4,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: logout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Выход',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kSFProDisplaySemiBold.copyWith(
                        fontSize: MediaQuery.of(context).size.width / 100 * 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
