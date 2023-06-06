import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/widgets/buttons/rounded_border_button.dart';
import '../../../../core/constants/styles/styles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/sms_code_input.dart';
import 'start_page.dart';

class SmsCodeConfirmationPage extends StatefulWidget {
  final String phoneNumber;
  const SmsCodeConfirmationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<SmsCodeConfirmationPage> createState() =>
      _SmsCodeConfirmationPageState();
}

class _SmsCodeConfirmationPageState extends State<SmsCodeConfirmationPage> {
  Timer? _timer;
  late final ValueNotifier<bool> _isIncorrectCodeNotifier;
  late final ValueNotifier<int> _codeLengthNotifier;
  late final TextEditingController _codeController;
  late final ValueNotifier<int> _secondsNotifier;
  late final FocusNode _codeFocus;

  @override
  void initState() {
    _secondsNotifier = ValueNotifier<int>(35);
    _timer = Timer.periodic(const Duration(milliseconds: 1000), _onTick);
    _codeController = TextEditingController()..addListener(_codeListener);
    _isIncorrectCodeNotifier = ValueNotifier<bool>(false);
    _codeLengthNotifier = ValueNotifier<int>(0);
    _codeFocus = FocusNode()..requestFocus();
    super.initState();
  }

  void _onTick(Timer timer) {
    if (_secondsNotifier.value == 0) {
      timer.cancel();
    } else {
      _secondsNotifier.value = _secondsNotifier.value - 1;
    }
  }

  void _sendCodeAgain() {
    _timer?.cancel();
    _secondsNotifier.value = 35;
    _timer = Timer.periodic(const Duration(milliseconds: 1000), _onTick);
    context.read<AuthBloc>().add(
          AuthSendPhoneCodeEvent(
            phoneNumber: widget.phoneNumber,
          ),
        );
  }

  void _codeListener() {
    _codeLengthNotifier.value = _codeController.text.length;
    context.read<AuthBloc>().add(
          AuthCheckPhoneCodeEvent(
            code: _codeController.text,
          ),
        );
  }

  void _navigateToStartPage() => Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.fade,
          child: const StartPage(),
        ),
      );

  @override
  void dispose() {
    _timer?.cancel();
    _secondsNotifier.dispose();
    _isIncorrectCodeNotifier.dispose();
    _codeLengthNotifier.dispose();
    _codeController.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthActionState,
      listener: (context, state) {
        if (state is AuthPhoneCodeVerifiedState) {
          _codeFocus.unfocus();
          context.read<AuthBloc>().add(
                AuthLoginWithPhoneEvent(
                  phoneNumber: widget.phoneNumber,
                ),
              );
          _navigateToStartPage();
        }
        if (state is AuthPhoneCodeErrorState) {
          _isIncorrectCodeNotifier.value = true;
        }
        if (state is AuthPhoneCodeInputState) {
          _isIncorrectCodeNotifier.value = false;
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimationYDown(
                          delay: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 58,
                              right: 20,
                            ),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(20),
                              child: SvgPicture.asset(
                                'assets/icons/arrow_back.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        FadeAnimationYDown(
                          delay: .6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              'Введите код подтверждения полученный по СМС',
                              style: kSFProDisplayRegular.copyWith(
                                color: kBlack,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        FadeAnimationYDown(
                          delay: .7,
                          child: ValueListenableBuilder(
                            valueListenable: _isIncorrectCodeNotifier,
                            builder: (context, isIncorrectCode, _) =>
                                ValueListenableBuilder(
                              valueListenable: _codeLengthNotifier,
                              builder: (context, codeLength, _) => SmsCodeInput(
                                isIncorrectCode: isIncorrectCode,
                                padding: codeLength == 0
                                    ? const EdgeInsets.symmetric(horizontal: 48)
                                    : codeLength < 4
                                        ? const EdgeInsets.only(
                                            left: 21,
                                            right: 48,
                                          )
                                        : const EdgeInsets.symmetric(
                                            horizontal: 21),
                                codeFocus: _codeFocus,
                                codeController: _codeController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        children: [
                          FadeAnimationYDown(
                            delay: .8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: ValueListenableBuilder(
                                valueListenable: _secondsNotifier,
                                builder: (context, seconds, _) {
                                  if (seconds > 0) {
                                    return RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: 'Отправить код повторно ',
                                        style: kSFProDisplayMedium.copyWith(
                                          fontSize: 16,
                                          color: kBlack50,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '$seconds сек.',
                                            style: kSFProDisplayMedium.copyWith(
                                              fontSize: 16,
                                              color: kBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return RoundedBorderButton(
                                      onTap: _sendCodeAgain,
                                      borderColor: kBlack.withOpacity(
                                        .2,
                                      ),
                                      children: [
                                        Text(
                                          'Отправить код повторно',
                                          style: kSFProDisplayMedium.copyWith(
                                            fontSize: 16,
                                            color: kBlack,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
