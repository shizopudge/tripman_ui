import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/styles/styles.dart';
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
    final int random = Random().nextInt(3);
    ScaffoldMessenger.of(context).showMaterialBanner(
      switch (random) {
        (int random) when random == 0 => const MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: [
              SizedBox(),
            ],
            content: MessageBanner(
              iconPath: 'assets/icons/checkbox.svg',
              text: 'Автоматическое разрешение проблемы',
              backgroundColor: kBlack,
            ),
          ),
        (int random) when random == 1 => const MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: [
              SizedBox(),
            ],
            content: MessageBanner(
              iconPath: 'assets/icons/error_cross.svg',
              text: 'Ошибка загрузки страниц, неполадок с сервером и тд',
              backgroundColor: kRed,
            ),
          ),
        (_) => const MaterialBanner(
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.symmetric(vertical: 8),
            dividerColor: Colors.transparent,
            actions: [
              SizedBox(),
            ],
            content: MessageBanner(
              iconPath: 'assets/icons/error.svg',
              text: 'Предупреждающие сообщения о работе системы',
              backgroundColor: kBlack50,
            ),
          ),
      },
    );
  }
}
