import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../theme_handler.dart';

///---------------------------------------
///          BRIEF INTRO SECTION
///---------------------------------------

Widget profileImage(BuildContext context){
  return profilePhoto;
}

Widget briefIntroTexts(BuildContext context){
  return Container(
    child: RichText(
      textAlign: isWeb(context) ? TextAlign.left : TextAlign.center,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: 'Hi, I\'m\n', style: Theme.of(context).textTheme.headline),
          TextSpan(text: 'Dhruvil Patel\n', style: isWeb(context) ? Theme.of(context).textTheme.display3 : Theme.of(context).textTheme.display2,),
          TextSpan(text: 'Full-stack Mobile/Web Developer\n', style: Theme.of(context).textTheme.headline,),
          TextSpan(text: 'UI/UX Designer\n', style: Theme.of(context).textTheme.headline,),
        ],
      ),
    ),
  );
}

///---------------------------------------
///          ABOUT ME SECTION
///---------------------------------------

Widget worldMapImage(BuildContext context){
  return isWeb(context) ? Padding(
    padding: const EdgeInsets.only(right: 80.0,),
    child: worldMap,
  ) : Center(
    child: worldMap,
  );
}

Widget aboutMeTexts(BuildContext context){
  return Container(
    child: RichText(
      textAlign: isWeb(context) ? TextAlign.left : TextAlign.justify,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: 'I', style: Theme.of(context).textTheme.display1,),
          TextSpan(text: aboutMeStr1, style: Theme.of(context).textTheme.title,),
          TextSpan(text: 'O', style: Theme.of(context).textTheme.display1),
          TextSpan(text: aboutMeStr2, style: Theme.of(context).textTheme.title,),
        ],
      ),
    ),
  );
}

///---------------------------------------
///          EDUCATION SECTION
///---------------------------------------

Widget educationCard(BuildContext context, String name, String major, String date, Image logo, String activities, List<String> courseWork){
  return Align(
    alignment: Alignment.topCenter,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: logo,
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0,),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: '$name\n', style: isWeb(context) ? Theme.of(context).textTheme.display1 : Theme.of(context).textTheme.title),
                              TextSpan(text: '$major\n', style: isWeb(context) ? Theme.of(context).textTheme.headline : Theme.of(context).textTheme.subhead,),
                              TextSpan(text: '$date\n', style: isWeb(context) ? Theme.of(context).textTheme.subhead : Theme.of(context).textTheme.body2,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlineButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onPressed: (){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Course Work', style: Theme.of(context).textTheme.headline,),
                              contentPadding: EdgeInsets.all(5.0,),
                              content: Container(
                                width: 400.0,
                                height: 375.0,
                                child: ListView(
                                  children: courseWork.map((String name) => ListTile(
                                    leading: Icon(Icons.subject),
                                    title: Text(name, style: Theme.of(context).textTheme.title,),
                                  )).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                        label: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0,),
                          child: Text('Courses', style: isWeb(context) ? Theme.of(context).textTheme.subhead : Theme.of(context).textTheme.body1,),
                        ),
                        icon: Icon(Icons.book, color: Theme.of(context).primaryColor,),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        splashColor: Theme.of(context).scaffoldBackgroundColor,
                        hoverColor: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: isWeb(context) ? const EdgeInsets.only(right: 45.0, left: 45.0, top: 20.0,) : EdgeInsets.only(top: 20.0,),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: 'Activities & Achievements:\n', style: Theme.of(context).textTheme.subhead),
                TextSpan(text: activities, style: isWeb(context) ? Theme.of(context).textTheme.title : TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0, fontFamily: 'Quicksand',),),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}