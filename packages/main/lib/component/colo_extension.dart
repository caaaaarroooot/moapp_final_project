import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xff92a3fd);
  static Color get primaryColor2 => const Color(0xff9dceff);

  static Color get secondaryColor1 => const Color(0xffc58bf2);
  static Color get secondaryColor2 => const Color(0xffeea4ce);

  static List<Color> get primaryG => [primaryColor2, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get black => const Color(0xff1d1617);
  static Color get gray => const Color(0xff7b6f72);
  static Color get white => const Color(0xffffffff);
  static Color get lightGray => const Color(0xfff7f8f8);
}
