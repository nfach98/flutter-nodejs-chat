import 'package:flutter/material.dart';

Map<int, Color> primaries = {
  50: const Color.fromRGBO(0, 51, 255, .1),
  100: const Color.fromRGBO(0, 51, 255, .2),
  200: const Color.fromRGBO(0, 51, 255, .3),
  300: const Color.fromRGBO(0, 51, 255, .4),
  400: const Color.fromRGBO(0, 51, 255, .5),
  500: const Color.fromRGBO(0, 51, 255, .6),
  600: const Color.fromRGBO(0, 51, 255, .7),
  700: const Color.fromRGBO(0, 51, 255, .8),
  800: const Color.fromRGBO(0, 51, 255, .9),
  900: const Color.fromRGBO(0, 51, 255, 1),
};

var colorPrimary = MaterialColor(0xFF0033FF, primaries);
var colorAccent = MaterialColor(0xFFF1DD55, primaries);
