import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/authorization/presentation/bloc/phone_code_verification_cubit/phone_code_verification_cubit.dart';
import 'features/authorization/presentation/pages/start_page.dart';
import 'styles/styles.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(
          create: (_) => PhoneCodeVerificationCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kBlack),
          fontFamily: 'SF-Pro-Display',
          useMaterial3: true,
        ),
        home: const StartPage(),
      ),
    );
  }
}
