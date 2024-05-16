import 'package:flutter/material.dart';

class ColorUtils {
  static int hexToInt(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    if(hex.length==6){
      hex = "ff$hex" ;
    }
    return int.parse(hex, radix: 16);
  }

  static String intToHex(int value) {
    return value.toRadixString(16).padLeft(6, '0');
  }
}
class Colours{
  static const Color lokiBeige = Color(0xffd6d3ae);
  static const Color lokiLightGreen = Color(0xff50630d);
  static const Color lokiLightBeige = Color(0xffE4CFA0);
  static const Color lokiGold = Color(0xffECBA3D);
  static const Color lokiDarkGreen = Color(0xff0b450a);
  static const Color lokiBlack = Color(0xff071a03);


  static Color invertColor(Color c){
    int r = 255 - c.red;
    int g = 255 - c.green;
    int b = 255 - c.blue;
    return Color.fromRGBO(r, g, b, 1);
  }

}