import 'package:flutter/material.dart';

class Pallete {
  Pallete._();

  static const extremegreed = Color(0xff8cd6c3);
  static const greed = Color(0xffb9ede9);
  static const neutral = Color(0xffe6e6e6);
  static const fear = Color.fromARGB(254, 255, 185, 161);
  static const extremefear = Color.fromARGB(254, 255, 129, 122);

  static Map<String,dynamic> colorMap = {
    'Extreme Greed' : extremegreed,
    'Greed' : greed,
    'Neutral' : neutral,
    'Fear' : fear,
    'Extreme Fear' : extremefear,
  };
}