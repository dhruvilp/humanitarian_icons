import 'package:flutter/material.dart';
import '../../theme_handler.dart';

Widget activityCard(BuildContext context, String name, String url, Image image){
  return Padding(
    padding: isWeb(context) ? const EdgeInsets.only(right: 60.0,) : EdgeInsets.all(0.0),
    child: Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(15.0),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        hoverColor: Theme.of(context).primaryColorLight,
        onTap: (){
          launchURL(url);
        },
        child: Center(
          child: image,
        ),
      ),
    ),
  );
}