import 'package:flutter/widgets.dart';

class Sc {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double h;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;

    screenHeight = _mediaQueryData.size.height;
    h = screenWidth / 100;
    v = screenWidth / 100;
  }
}
