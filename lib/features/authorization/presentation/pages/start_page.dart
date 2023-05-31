import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/loader.dart';
import '../../../../core/enums/authorization_type.dart';
import '../../../../styles/styles.dart';
import '../bloc/authorization_bloc.dart';
import '../widgets/authorization_type_menu.dart';
import '../widgets/logo.dart';
import 'login_with_phone_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({
    super.key,
  });

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late final ValueNotifier<double> _opacityNotifier;

  @override
  void initState() {
    _opacityNotifier = ValueNotifier<double>(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _opacityNotifier.dispose();
    super.dispose();
  }

  void _navigateToHomePage(BuildContext context) => Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text(
                'Successfully authorized',
              ),
            ),
          ),
        ),
      );

  void _navigateToLoginWithPhonePage(BuildContext context) =>
      Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.bottomToTop,
          child: const LoginWithPhonePage(),
        ),
      );

  void _login(BuildContext context, AuthorizationType authorizationType) {
    _opacityNotifier.value = 0.0;
    Future.delayed(
      const Duration(milliseconds: 500),
      () => context.read<AuthorizationBloc>().add(
            AuthorizationLoginEvent(authorizationType: authorizationType),
          ),
    ).whenComplete(() => _opacityNotifier.value = 1.0);
  }

  void _tryAgain(BuildContext context) => context.read<AuthorizationBloc>().add(
        AuthorizationTryAgainEvent(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: BlocProvider(
        create: (context) => AuthorizationBloc(),
        child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
          listenWhen: (previous, current) =>
              current is AuthorizationActionState,
          buildWhen: (previous, current) =>
              current is! AuthorizationActionState,
          listener: (context, state) {
            if (state is AuthorizationAuthorizedState) {
              _navigateToHomePage(context);
            }
            if (state is AuthorizationLoginWithPhoneState) {
              _navigateToLoginWithPhonePage(context);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case AuthorizationInititalState:
                return SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        const Logo(),
                        const Spacer(),
                        AuthorizationTypeMenu(
                          opacityNotifier: _opacityNotifier,
                          withPhone: () => _login(
                            context,
                            AuthorizationType.phone,
                          ),
                          withGoogle: () => _login(
                            context,
                            AuthorizationType.google,
                          ),
                          withApple: () => _login(
                            context,
                            AuthorizationType.apple,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case AuthorizationLoadingState:
                return const SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Logo(),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 90),
                          child: FadeAnimationYUp(
                            delay: .25,
                            child: Loader(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case AuthorizationErrorState:
                final errorState = state as AuthorizationErrorState;
                return SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        FadeAnimationYDown(
                          delay: 1,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/error.svg',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                errorState.message,
                                textAlign: TextAlign.center,
                                style: kSFProDisplayRegular.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 90),
                          child: FadeAnimationYDown(
                            delay: 1,
                            child: InkWell(
                              onTap: () => _tryAgain(context),
                              borderRadius: BorderRadius.circular(20),
                              child: SvgPicture.asset(
                                'assets/icons/reload.svg',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
