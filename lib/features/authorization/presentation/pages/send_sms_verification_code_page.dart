import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/constants/styles/styles.dart';
import '../../../../core/utils/navigation_utils.dart';
import '../../../../core/widgets/buttons/rounded_text_button.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/widgets/common/default_text_field.dart';
import '../../../../core/widgets/text/notice.dart';
import 'sms_code_confirmation_page.dart';

class SendSmsVerificationCodePage extends StatefulWidget {
  const SendSmsVerificationCodePage({super.key});

  @override
  State<SendSmsVerificationCodePage> createState() =>
      _SendSmsVerificationCodePageState();
}

class _SendSmsVerificationCodePageState
    extends State<SendSmsVerificationCodePage> {
  late final TextEditingController _phoneController;
  late final ValueNotifier<bool> _isEmptyNotifier;
  late final ValueNotifier<bool> _isValidatedNotifier;
  late final FocusNode _phoneFieldFocusNode;
  final _maskFormatter = MaskTextInputFormatter(
    mask: '+7 ### ## ## ###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    _phoneController = TextEditingController()..addListener(_phoneListener);
    _phoneFieldFocusNode = FocusNode()..requestFocus();
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

    if (_maskFormatter.isFill()) {
      _isValidatedNotifier.value = true;
    } else {
      _isValidatedNotifier.value = false;
    }
  }

  void _clearTextField() {
    _maskFormatter.clear();
    _phoneController.clear();

    if (!_phoneFieldFocusNode.hasPrimaryFocus) {
      _phoneFieldFocusNode.requestFocus();
    }
  }

  void _navigateToCodeConfirmationPage() => NavigationUtils.pushWithFade(
        context: context,
        page: SmsCodeConfirmationPage(
          phoneNumber: _phoneController.text,
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
      body: SafeArea(
        child: LayoutBuilder(
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
                          delay: .6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 30,
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
                          delay: .7,
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
                          delay: .8,
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
                          delay: .9,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 21,
                              right: 19,
                            ),
                            child: ValueListenableBuilder(
                              valueListenable: _isEmptyNotifier,
                              builder: (context, isEmpty, _) =>
                                  DefaultTextField(
                                inputFormatters: [
                                  _maskFormatter,
                                ],
                                onClear: _clearTextField,
                                controller: _phoneController,
                                focusNode: _phoneFieldFocusNode,
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
                            delay: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: ValueListenableBuilder(
                                valueListenable: _isValidatedNotifier,
                                builder: (context, isValidated, _) =>
                                    RoundedTextButton(
                                  isEnabled: isValidated,
                                  onTap: () {
                                    _sendVerificationCode();
                                    _navigateToCodeConfirmationPage();
                                  },
                                  text: 'Подтвердить номер',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const FadeAnimationYDown(
                            delay: 1.1,
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
      ),
    );
  }
}
