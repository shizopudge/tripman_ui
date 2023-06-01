import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_limiter/rate_limiter.dart';

import '../../../../core/common_widgets/rounded_text_button.dart';
import '../../../../core/enums/auth_type.dart';
import '../../../../styles/styles.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/phone_code_verification_cubit/phone_code_verification_cubit.dart';
import 'start_page.dart';

class CodeConfirmationPage extends StatefulWidget {
  final String phoneNumber;
  const CodeConfirmationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<CodeConfirmationPage> createState() => _CodeConfirmationPageState();
}

class _CodeConfirmationPageState extends State<CodeConfirmationPage> {
  Timer? _timer;
  late final ValueNotifier<bool> _isIncorrectCodeNotifier;
  late final TextEditingController _codeController;
  late final ValueNotifier<int> _secondsNotifier;

  late final FocusNode _codeFocus;
  late final Throttle throttledUnfocus;

  @override
  void initState() {
    _secondsNotifier = ValueNotifier<int>(35);
    _timer = Timer.periodic(const Duration(milliseconds: 1000), _onTick);
    _codeController = TextEditingController()..addListener(_codeListener);
    _isIncorrectCodeNotifier = ValueNotifier<bool>(false);
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
    context
        .read<PhoneCodeVerificationCubit>()
        .sendVerificationCode(phoneNumber: widget.phoneNumber);
  }

  void _codeListener() {
    context
        .read<PhoneCodeVerificationCubit>()
        .authCheckPhoneCodeEvent(code: _codeController.text);
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
    _codeController.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneCodeVerificationCubit, PhoneCodeVerificationState>(
      listenWhen: (previous, current) =>
          current is! PhoneCodeVerificationInitialState,
      listener: (context, state) {
        if (state is PhoneCodeVerificationVerifiedState) {
          _isIncorrectCodeNotifier.value = false;
          _codeFocus.unfocus();
          context.read<AuthBloc>().add(
                AuthLoginEvent(
                  authType: AuthType.phone,
                ),
              );
          _navigateToStartPage();
        }
        if (state is PhoneCodeVerificationErrorState) {
          _isIncorrectCodeNotifier.value = true;
        }
        if (state is PhoneCodeVerificationInputState) {
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
                        Padding(
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
                        const SizedBox(
                          height: 23,
                        ),
                        Padding(
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
                        const SizedBox(
                          height: 28,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _isIncorrectCodeNotifier,
                          builder: (context, isIncorrectCode, child) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 21),
                            child: Column(
                              children: [
                                Pinput(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  focusNode: _codeFocus,
                                  controller: _codeController,
                                  showCursor: false,
                                  length: 4,
                                  closeKeyboardWhenCompleted: false,
                                  forceErrorState: isIncorrectCode,
                                  defaultPinTheme: PinTheme(
                                    height: 8,
                                    width: 8,
                                    textStyle: kSFProDisplaySemiBold.copyWith(
                                      color: kBlack.withOpacity(
                                        .2,
                                      ),
                                      height: 1,
                                      fontSize: 45,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kBlack.withOpacity(
                                        .2,
                                      ),
                                    ),
                                  ),
                                  focusedPinTheme: PinTheme(
                                    height: 12,
                                    width: 12,
                                    textStyle: kSFProDisplaySemiBold.copyWith(
                                      color: kBlack,
                                      height: 1,
                                      fontSize: 45,
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kBlack,
                                    ),
                                  ),
                                  submittedPinTheme: PinTheme(
                                    textStyle: kSFProDisplaySemiBold.copyWith(
                                      color: kBlack,
                                      height: 1,
                                      fontSize: 45,
                                    ),
                                  ),
                                  errorPinTheme: PinTheme(
                                    textStyle: kSFProDisplaySemiBold.copyWith(
                                      color: kRed,
                                      height: 1,
                                      fontSize: 45,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                if (isIncorrectCode)
                                  Text(
                                    'Не верный код',
                                    style: kSFProDisplayRegular.copyWith(
                                      color: kRed,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
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
                          Padding(
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
                                  return RoundedTextButton(
                                    backgroundColor: Colors.transparent,
                                    borderColor: kBlack.withOpacity(.2),
                                    textColor: kBlack,
                                    text: 'Отправить код повторно',
                                    onTap: _sendCodeAgain,
                                  );
                                }
                              },
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
