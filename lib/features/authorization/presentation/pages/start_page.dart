import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/animations/fade_animation_y_down.dart';
import '../../../../core/animations/fade_animation_y_up.dart';
import '../../../../core/common_widgets/loader.dart';
import '../../../../core/enums/auth_type.dart';
import '../../../../styles/styles.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/authorization_type_menu.dart';
import '../widgets/logo.dart';
import 'login_with_phone_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
  });

  void _navigateToHomePage(BuildContext context) => Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.fade,
          child: const HomePage(),
        ),
      );

  void _navigateToLoginWithPhonePage(BuildContext context) =>
      Navigator.of(context).push(
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.fade,
          child: const LoginWithPhonePage(),
        ),
      );

  void _login(BuildContext context, AuthType authType) =>
      context.read<AuthBloc>().add(
            AuthLoginEvent(authType: authType),
          );

  void _tryAgain(BuildContext context) => context.read<AuthBloc>().add(
        AuthTryAgainEvent(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlack,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is AuthAuthorizedState) {
            _navigateToHomePage(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AuthInititalState:
              return SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      const Logo(),
                      const Spacer(),
                      AuthorizationTypeMenu(
                        withPhone: () => _navigateToLoginWithPhonePage(context),
                        withGoogle: () => _login(
                          context,
                          AuthType.google,
                        ),
                        withApple: () => _login(
                          context,
                          AuthType.apple,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case AuthLoadingState:
              return const SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      Logo(),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 90,
                        ),
                        child: FadeAnimationYUp(
                          delay: .25,
                          child: Loader(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case AuthErrorState:
              final errorState = state as AuthErrorState;
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
                        padding: const EdgeInsets.only(
                          bottom: 90,
                        ),
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
    );
  }
}