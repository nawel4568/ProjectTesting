import 'package:flutter/painting.dart';

class ThemeColor {
  late List<Color> gradient;
  late Color backgroundColor;
  late Color toggleButtonColor;
  late Color toggleBackgroundColor;
  late Color textColor;
  late List<BoxShadow> shadow;

  ThemeColor({
    required this.gradient,
    required this.backgroundColor,
    required this.toggleBackgroundColor,
    required this.toggleButtonColor,
    required this.textColor,
    required this.shadow,
  });
}