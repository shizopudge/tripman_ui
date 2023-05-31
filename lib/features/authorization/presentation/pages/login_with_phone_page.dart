import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../styles/styles.dart';
import '../widgets/login_confirm_phone_button.dart';
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

  @override
  void initState() {
    _phoneController = TextEditingController()..addListener(_onChange);
    _isEmptyNotifier = ValueNotifier<bool>(true);
    _isValidatedNotifier = ValueNotifier<bool>(false);
    super.initState();
  }

  void _onChange() {
    debugPrint('Phone changed');
    if (_phoneController.text.isNotEmpty) {
      _isEmptyNotifier.value = false;
    }
    if (_phoneController.text.length > 3) {
      _isValidatedNotifier.value = true;
    } else {
      _isValidatedNotifier.value = false;
    }
  }

  void _navigateToCodeConfirmationPage() => Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.fade,
          child: const CodeConfirmationPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 58, right: 20),
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
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Для использования приложения\nпожалуйста укажите ваш номер телефона',
                  style: kSFProDisplayRegular.copyWith(
                    color: kBlack,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21, right: 19),
                child: Text(
                  'Номер телефона',
                  style: kSFProDisplayRegular.copyWith(
                    color: kBlack50,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21, right: 19),
                child: LoginPhoneTextField(
                  isEmptyNotifier: _isEmptyNotifier,
                  phoneController: _phoneController,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: LoginConfirmPhoneButton(
                  onTap: () => _navigateToCodeConfirmationPage(),
                  isValidatedNotifier: _isValidatedNotifier,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Notice(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
