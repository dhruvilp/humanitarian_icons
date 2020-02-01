import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Palette
const cyan_dark = const Color(0xFF114B5F);
const cyan = const Color(0xFF028090);
const off_cyan = const Color(0xFFE4FDE1);
const pink = const Color(0xFFF45B69);

//Triage Colors
const red = const Color(0xFFcc0000);
const red_light = const Color(0xFFdb4c4c);
const yellow = const Color(0xFFf2b022);
const yellow_light = const Color(0xFFf5c152);
const green = const Color(0xFF359935);
const green_light = const Color(0xFF3caf3c);

// Black & White
const white = Colors.white;
const grey_light = const Color(0xFFECEFF1);
const off_white = const Color(0xFFfff5e8);
const grey = const Color(0xFF898c8c);
const bluegrey = const Color(0xFF3E5569);
const charcoal_light = const Color(0xFF2f363d);
const charcoal = const Color(0xFF24292E);
const black = Colors.black;
const transparent = const Color(0x00ffffff);
const overlay = const Color.fromRGBO(0, 0, 0, 80);

const cyan_gradient = const LinearGradient(
  colors: [cyan, cyan_dark],
  begin: const FractionalOffset(0.4, 0.0),
  end: const FractionalOffset(0.0, 0.5),
  stops: [0.0, 1.0],
  tileMode: TileMode.clamp,
);

//  GoovingMaterialIcons: https://cdn.materialdesignicons.com/2.6.95/