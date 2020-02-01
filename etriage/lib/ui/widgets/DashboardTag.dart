import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/filestore.dart';
import '../../style.dart';
import 'PatientData.dart';

class DashboardTag extends StatefulWidget {
  DashboardTag(
      {this.url,
      this.initColor,
      this.expandColor,
      this.description,
      this.leadingText});

  final String leadingText;
  final String description;
  final Color initColor;
  final Color expandColor;
  final String url;

  @override
  _DashboardTagState createState() => _DashboardTagState();
}

class _DashboardTagState extends State<DashboardTag> {
  bool isExpanded = false;
  Dio dio = new Dio();
  var numberOfPatients;

  @override
  void initState() {
    _fetchPatientDataByTag();
    return super.initState();
  }

  _fetchPatientDataByTag() async {
    var authToken = await getStoredCredential();
    Response<List> kResponse =
        await dio.post(widget.url, data: {"token": authToken});
    numberOfPatients = kResponse.data.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Card(
        elevation: 0.0,
        color: (isExpanded == true) ? transparent : widget.initColor,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: ExpansionTile(
            backgroundColor: widget.expandColor,
            onExpansionChanged: (bool expanding) =>
                setState(() => isExpanded = expanding),
            leading: new Text(
              widget.leadingText,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: widget.leadingText == 'T2' ? charcoal : white,
                textBaseline: TextBaseline.alphabetic,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: CircleAvatar(
              backgroundColor: white,
              child: Text(
                numberOfPatients != null ? "$numberOfPatients" : '0',
                style: TextStyle(
                  fontSize: 16,
                  color: widget.initColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(
              widget.description,
              style: new TextStyle(
                color: widget.leadingText == 'T2' ? charcoal : white,
                textBaseline: TextBaseline.alphabetic,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            children: <Widget>[
              Text('Hello World', style: TextStyle(color: white)),
              PatientData(
                url: widget.url,
                totalPatients: numberOfPatients,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
