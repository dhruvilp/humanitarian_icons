import 'package:flutter/cupertino.dart';

/// ENDPOINTS

const API = 'https://triagebackend.us-south.cf.appdomain.cloud';

/// APP LAYOUT
bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= 768;
}

bool isWeb(BuildContext context) {
  return MediaQuery.of(context).size.width > 768;
}