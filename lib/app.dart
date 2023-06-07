import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authorization/presentation/bloc/auth_bloc.dart';
import 'core/styles/styles.dart';
import 'features/authorization/presentation/pages/start_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
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
