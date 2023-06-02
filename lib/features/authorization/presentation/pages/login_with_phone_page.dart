import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tripman/core/common_widgets/rounded_text_button.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/styles/styles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_phone_textfield.dart';
import '../widgets/notice.dart';
import 'code_confirmation_page.dart';

class LoginWithPhonePage extends StatefulWidget {
  const LoginWithPhonePage({super.key});

  @override
  State<LoginWithPhonePage> createState() => _LoginWithPhonePageState();
}

class _LoginWithPhonePageState extends State<LoginWithPhonePage> {
  late final TextEditingController _phoneController;
  late final ValueNotifier<bool> _isEmptyNotifier;
  late final ValueNotifier<bool> _isValidatedNotifier;
  late final FocusNode _phoneFieldFocusNode;

  @override
  void initState() {
    _phoneController = TextEditingController()..addListener(_phoneListener);
    _phoneFieldFocusNode = FocusNode();
    _isEmptyNotifier = ValueNotifier<bool>(true);
    _isValidatedNotifier = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _isEmptyNotifier.dispose();
    _isValidatedNotifier.dispose();
    _phoneFieldFocusNode.dispose();
    super.dispose();
  }

  void _phoneListener() {
    if (_phoneController.text.isNotEmpty) {
      _isEmptyNotifier.value = false;
    } else {
      _isEmptyNotifier.value = true;
    }
    if (_phoneController.text.length > 3) {
      _isValidatedNotifier.value = true;
    } else {
      _isValidatedNotifier.value = false;
    }
  }

  void _clearTextField() {
    _phoneController.clear();
    if (!_phoneFieldFocusNode.hasPrimaryFocus) {
      _phoneFieldFocusNode.requestFocus();
    }
  }

  void _navigateToCodeConfirmationPage() => Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.fade,
          child: CodeConfirmationPage(
            phoneNumber: _phoneController.text,
          ),
        ),
      );

  void _sendVerificationCode() => context.read<AuthBloc>().add(
        AuthSendPhoneCodeEvent(
          phoneNumber: _phoneController.text,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimationYDown(
                        delay: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            top: 58,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(20),
                                child: SvgPicture.asset(
                                  'assets/icons/arrow_back.svg',
                                ),
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              Text(
                                'Вход',
                                style: kSFProDisplaySemiBold.copyWith(
                                  color: kBlack,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FadeAnimationYDown(
                        delay: 1.11,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'Для использования приложения пожалуйста укажите ваш номер телефона',
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
                        delay: 1.2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 21,
                            right: 19,
                          ),
                          child: Text(
                            'Номер телефона',
                            style: kSFProDisplayRegular.copyWith(
                              color: kBlack50,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FadeAnimationYDown(
                        delay: 1.3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 21,
                            right: 19,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: _isEmptyNotifier,
                            builder: (context, isEmpty, _) =>
                                LoginPhoneTextField(
                              onClear: _clearTextField,
                              phoneController: _phoneController,
                              phoneFieldFocusNode: _phoneFieldFocusNode,
                              isEmpty: isEmpty,
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
                          delay: 1.4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: ValueListenableBuilder(
                              valueListenable: _isValidatedNotifier,
                              builder: (context, isValidated, _) =>
                                  RoundedTextButton(
                                backgroundColor:
                                    isValidated ? kBlack : kBlack10,
                                textColor: isValidated ? kWhite : kBlack50,
                                text: 'Подтвердите номер',
                                onTap: isValidated
                                    ? () {
                                        _sendVerificationCode();
                                        _navigateToCodeConfirmationPage();
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const FadeAnimationYDown(
                          delay: 1.5,
                          child: Notice(),
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
    );
  }
}
