import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/styles/styles.dart';
import '../widgets/dialogs/confirmation_banner.dart';
import '../widgets/dialogs/message_banner.dart';

class PopupUtils {
  static Future<void> showMyBottomSheet({
    required BuildContext context,
    required Widget bottomSheet,
  }) async =>
      showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return bottomSheet;
        },
      );

  static void showBanner({
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    final int random = Random().nextInt(4);
    ScaffoldMessenger.of(context).showMaterialBanner(
      switch (random) {
        (int random) when random == 0 => MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: const EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: const [
              SizedBox(),
            ],
            content: MessageBanner(
              onTap: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
              iconPath: 'assets/icons/checkbox.svg',
              text: 'Автоматическое разрешение проблемы',
              buttonText: 'Кнопка',
              backgroundColor: kBlack,
            ),
          ),
        (int random) when random == 1 => MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: const EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: const [
              SizedBox(),
            ],
            content: MessageBanner(
              onTap: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
              iconPath: 'assets/icons/error_cross.svg',
              text: 'Ошибка загрузки страниц, неполадок с сервером и тд',
              buttonText: 'Кнопка',
              backgroundColor: kRed,
            ),
          ),
        (int random) when random == 2 => MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: const EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: const [
              SizedBox(),
            ],
            content: ConfirmationBanner(
              iconPath: 'assets/icons/network.svg',
              text: 'Ошибка загрузки страниц, неполадок с сервером и тд',
              backgroundColor: kWhite,
              onTap: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
              buttonText: 'Обновить',
            ),
          ),
        (_) => MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: const EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: const [
              SizedBox(),
            ],
            content: MessageBanner(
              onTap: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
              iconPath: 'assets/icons/error.svg',
              text: 'Предупреждающие сообщения о работе системы',
              buttonText: 'Кнопка',
              backgroundColor: kBlack50,
            ),
          ),
      },
    );
  }
}
