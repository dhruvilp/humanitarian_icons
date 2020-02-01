import 'package:dhruvilp/colors.dart';
import 'package:dhruvilp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

final kLightTheme = _buildLightTheme();
final kDarkTheme = _buildDarkTheme();

/*
NAME       SIZE   WEIGHT   SPACING  2018 NAME
display4   112.0  thin     0.0      headline1
display3   56.0   normal   0.0      headline2
display2   45.0   normal   0.0      headline3
display1   34.0   normal   0.0      headline4
headline   24.0   normal   0.0      headline5
title      20.0   medium   0.0      headline6
subhead    16.0   normal   0.0      subtitle1
body2      14.0   medium   0.0      body1
body1      14.0   normal   0.0      body2
caption    12.0   normal   0.0      caption
button     14.0   medium   0.0      button
subtitle   14.0   medium   0.0      subtitle2
overline   10.0   normal   0.0      overline
*/
///---------------------------------------
///             LIGHT THEME
///---------------------------------------
ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    primaryColor: blue,
    primaryColorLight: grey_light,
    primaryColorDark: blue_dark,
    accentColor: yellow,
    backgroundColor: white,
    scaffoldBackgroundColor: white,
    hoverColor: grey,
    fontFamily: 'Quicksand',
    dividerTheme: DividerThemeData(
      color: grey_light,
      thickness: 2.0,
    ),
    textTheme: TextTheme(
      display4: TextStyle(fontSize: 100.0, color: grey_light, fontWeight: FontWeight.w200, fontFamily: 'Monoton',),
      display3: TextStyle(fontSize: 90.0, color: blue, fontWeight: FontWeight.bold,),
      display2: TextStyle(fontSize: 45.0, color: blue,),
      display1: TextStyle(fontSize: 35.0, color: blue,),
      headline: TextStyle(fontSize: 25.0, color: charcoal_light, fontWeight: FontWeight.w200,),
      title: TextStyle(fontSize: 20.0, color: blue, fontWeight: FontWeight.w200,),
      subhead: TextStyle(fontSize: 18.0, color: charcoal_light,),
      body2: TextStyle(color: blue,),
      body1: TextStyle(color: charcoal_light,),
    ),
  );

  return base;
}

///---------------------------------------
///             DARK THEME
///---------------------------------------
ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    primaryColor: radium,
    primaryColorLight: radium_light,
    primaryColorDark: radium_dark,
    accentColor: yellow,
    scaffoldBackgroundColor: charcoal,
    hoverColor: radium_dark,
    backgroundColor: charcoal,
    fontFamily: 'Quicksand',
    dividerTheme: DividerThemeData(
      color: charcoal_light,
      thickness: 2.0,
    ),
    textTheme: TextTheme(
      display4: TextStyle(fontSize: 100.0, color: radium_dark, fontWeight: FontWeight.w200, fontFamily: 'Monoton',),
      display3: TextStyle(fontSize: 90.0, color: radium, fontWeight: FontWeight.bold,),
      display2: TextStyle(fontSize: 45.0, color: radium,),
      display1: TextStyle(fontSize: 35.0, color: radium,),
      headline: TextStyle(fontSize: 25.0, color: white, fontWeight: FontWeight.w200,),
      title: TextStyle(fontSize: 20.0, color: radium, fontWeight: FontWeight.w200,),
      subhead: TextStyle(fontSize: 18.0, color: white,),
      body2: TextStyle(color: radium,),
      body1: TextStyle(color: white,),
    ),
  );

  return base;
}

class ThemeHandler extends ChangeNotifier {
  static const _kDarkModePrefKey = 'DARK_MODE';
  final SharedPreferences _pref;
  ThemeHandler(this._pref);

  bool get isDarkMode => _pref?.getBool(_kDarkModePrefKey) ?? false;

  void setDarkMode(bool val) {
    _pref?.setBool(_kDarkModePrefKey, val);
    notifyListeners();
  }
}


///---------------------------------------
///            URL LAUNCHERS
///---------------------------------------
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true,);
  } else {
    throw 'Could not launch $url';
  }
}

launchMailClient(String kEmail) async {
  try {
    await launch(EMAIL_LINK);
  } catch (e) {
    await Clipboard.setData(ClipboardData(text: kEmail));
  }
}

///---------------------------------------
///           APP LAYOUT CHECK
///---------------------------------------
bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= 845;
}

bool isWeb(BuildContext context) {
  return MediaQuery.of(context).size.width > 845;
}