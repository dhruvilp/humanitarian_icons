import 'package:flutter/material.dart';
import '../../theme_handler.dart';

Widget contactCard(BuildContext context, String name, String url, Image image){
  return Expanded(
    flex: 1,
    child: rawContactCard(context, name, url, image),
  );
}

Widget rawContactCard(BuildContext context, String name, String url, Image image){
  return Padding(
    padding: isWeb(context) ? const EdgeInsets.all(15.0) : EdgeInsets.only(right: 50.0, left: 50.0,),
    child: Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        hoverColor: Theme.of(context).primaryColorLight,
        onTap: (){
          (url.contains('mailto:')) ? launchMailClient(url) : launchURL(url);
        },
        child: Padding(
          padding: isWeb(context) ? const EdgeInsets.only(top: 25.0, bottom: 25.0, right: 15.0, left: 15.0,) : EdgeInsets.all(8.0),
          child: isWeb(context) ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: image,
              ),
              Container(
                child: Text(name, style: Theme.of(context).textTheme.subhead,),
              ),
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Expanded(
                  flex: 1,
                  child: image,
                ),
              ),
              Container(
                child: Expanded(
                  flex: 5,
                  child: Text(name, style: Theme.of(context).textTheme.subhead,),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}