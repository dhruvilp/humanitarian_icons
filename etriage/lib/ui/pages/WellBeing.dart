import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style.dart';


class WellBeing extends StatefulWidget {
  @override
  _WellBeingState createState() => _WellBeingState();
}

class _WellBeingState extends State<WellBeing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Well-Being'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: Container(
              color: white,
              child: Text(
                'Well-Being of Emergency Responders',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(
                25.0,
              ),
              color: white,
              child: Text(
                'Future Implementation: \n\nChatbot for emergency responders to talk about their feelings after triage. Especially, after tagging more T1 & T4 tags.\n'
                'Furthermore, vital readings from responder\'s watch could be shown here.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
