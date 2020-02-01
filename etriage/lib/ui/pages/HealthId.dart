import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style.dart';

class HealthID extends StatefulWidget {
  @override
  _HealthIDState createState() => _HealthIDState();
}

class _HealthIDState extends State<HealthID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Id'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: white,
            child: Image.asset(
              'assets/qr.png',
              height: 150.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: white,
            child: Image.asset(
              'assets/healthId.jpg',
              height: 500.0,
            ),
          ),
        ],
      ),
    );
  }
}
