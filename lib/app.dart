import 'package:flutter/material.dart';

import 'features/authorization/presentation/pages/start_page.dart';
import 'styles/styles.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kBlack),
        fontFamily: 'SF-Pro-Display',
        useMaterial3: true,
      ),
      home: const StartPage(),
    );
  }
}
