import 'package:flutter/material.dart';

import '../../utils/popup_utils.dart';
import '../bottom_sheet/sized_bottom_sheet.dart';
import '../../constants/styles/styles.dart';

class Notice extends StatelessWidget {
  const Notice({super.key});

  void _onTap(BuildContext context) => PopupUtils.showMyBottomSheet(
        context: context,
        bottomSheet: SizedBottomSheet(
          heightFactor: .75,
          title:
              'Пользовательское соглашение и Правила обработки персональных данных',
          child: Text(
            '1. Общие положения\n\n1.1. Настоящая политика обработки персональных данных составлена в соответствии с требованиями Федерального закона от 27.07.2006. №152-ФЗ «О персональных данных» и определяет порядок обработки персональных данных и меры по обеспечению безопасности персональных данных, предпринимаемые ООО «ЗАО СМС» (далее – Оператор).\n1.2. Оператор ставит своей важнейшей целью и условием осуществления своей деятельности соблюдение прав и свобод человека и гражданина при обработке его персональных данных, в том числе защиты прав на неприкосновенность частной жизни, личную и семейную тайну.\n1.3. Настоящая политика Оператора в отношении обработки персональных данных (далее – Политика) применяется ко всей информации, которую Оператор может получить о посетителях веб-сайта\n\n2. Основные понятия, используемые в Политике\n\n2.1. Веб-сайт – совокупность графических и информационных материалов, а также программ для ЭВМ и баз данных.',
            style: kSFProDisplayRegular.copyWith(
              color: kBlack,
              fontSize: 15,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Text(
        'При входе на ресурс,\nвы принимаете условия доступа',
        textAlign: TextAlign.center,
        style: kSFProDisplayRegular.copyWith(
          fontSize: 14,
          color: kBlack,
        ),
      ),
    );
  }
}
