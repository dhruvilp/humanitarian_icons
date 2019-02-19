import 'package:flutter/material.dart';
import 'package:HackRU/colors.dart';

class Login extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
//    appBar: new AppBar(
//      backgroundColor: bluegrey,
//      title: new Text(
//        'Support HackRU',
//        style: new TextStyle(
//          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
//        ),
//      ),
//      elevation: 0.3,
//    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Login page content')
          ],
        )
      ],
    ),
  );
}