import 'dart:ui';

class MyColors {
  static final black = HexColor('#0E0E0E');
  static final grey = HexColor('#A1A1A1');
  static final white = HexColor('#FFFFFF');
  static final purple1 = HexColor('#471AA0');
  static final purple2 = HexColor('#9747FF');
  static final purple3 = HexColor('#CDAEF5');
  static final pink = HexColor('#BB84E8');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}