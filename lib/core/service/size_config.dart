import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }

  static double getWidth(double width) {
    if (blockSizeHorizontal == null || screenWidth == null) {
      return 0.0;
    }
    final a = width / blockSizeHorizontal!;
    return screenWidth! * (a / 100);
  }

  static double getHeigth(double height) {
    if (blockSizeVertical == null || screenHeight == null) {
      return 0.0;
    }
    final a = height / blockSizeVertical!;
    return screenHeight! * (a / 100);
  }
}
