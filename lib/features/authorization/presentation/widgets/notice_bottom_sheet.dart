import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class NoticeBottomSheet extends StatelessWidget {
  const NoticeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .8,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 6,
            width: MediaQuery.of(context).size.width * .2,
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kWhite,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Пользовательское соглашение и Правила обработки персональных данных',
                    style: kSFProDisplaySemiBold.copyWith(
                      color: kBlack,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '1. Общие положения\n\n1.1. Настоящая политика обработки персональных данных составлена в соответствии с требованиями Федерального закона от 27.07.2006. №152-ФЗ «О персональных данных» и определяет порядок обработки персональных данных и меры по обеспечению безопасности персональных данных, предпринимаемые ООО «ЗАО СМС» (далее – Оператор).\n1.2. Оператор ставит своей важнейшей целью и условием осуществления своей деятельности соблюдение прав и свобод человека и гражданина при обработке его персональных данных, в том числе защиты прав на неприкосновенность частной жизни, личную и семейную тайну.\n1.3. Настоящая политика Оператора в отношении обработки персональных данных (далее – Политика) применяется ко всей информации, которую Оператор может получить о посетителях веб-сайта\n\n2. Основные понятия, используемые в Политике\n\n2.1. Веб-сайт – совокупность графических и информационных материалов, а также программ для ЭВМ и баз данных.',
                    style: kSFProDisplayRegular.copyWith(
                      color: kBlack,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
