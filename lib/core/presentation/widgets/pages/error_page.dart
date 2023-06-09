import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../animations/fade_animation_y_down.dart';
import '../../animations/fade_animation_y_up.dart';
import '../../../styles/styles.dart';
import '../common/loader.dart';
import '../buttons/rounded_text_button.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  late final ValueNotifier<bool> _isLoadingNotifier;
  @override
  void initState() {
    _isLoadingNotifier = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  void _refresh() {
    _isLoadingNotifier.value = true;
    Future.delayed(
      const Duration(milliseconds: 2000),
      () => _isLoadingNotifier.value = false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: _isLoadingNotifier,
            builder: (context, isLoading, _) {
              if (isLoading) {
                return const FadeAnimationYDown(
                  delay: .5,
                  child: Center(
                    child: Loader(
                      color: kBlack,
                    ),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimationYDown(
                      delay: .5,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25, top: 20),
                          child: Icon(
                            Icons.arrow_back,
                            color: kBlack,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FadeAnimationYDown(
                      delay: .6,
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/network.svg',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Ошибка загрузки страниц,\nнеполадок с сервером и тд',
                              style: kSFProDisplayRegular.copyWith(
                                  fontSize: 15, color: kBlack),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    FadeAnimationYUp(
                      delay: .7,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedTextButton(
                          text: 'Обновить',
                          onTap: _refresh,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
