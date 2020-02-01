import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/filestore.dart';
import '../../style.dart';

class PatientData extends StatefulWidget {
  PatientData({this.url, this.totalPatients});

  final String url;
  final int totalPatients;

  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  Dio dio = new Dio();

  @override
  void initState() {
    _getPatientByTag();
    return super.initState();
  }

  _getPatientByTag() async {
    var authToken = await getStoredCredential();
    var kResponse = await dio.post(widget.url, data: {"token": authToken});
    var list = kResponse.data as List;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Center(
        child: FutureBuilder(
          future: _getPatientByTag(),
          builder: (context, snapshot) {
            var list = snapshot.data;
            print(snapshot.hasData);
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          'First Name:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: charcoal_light,
                          ),
                        ),
                        title: Text(
                          list[index]['first_name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: null,
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Last Name:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: charcoal_light,
                          ),
                        ),
                        title: Text(
                          list[index]['last_name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: null,
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Init \nObservations:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: charcoal_light,
                          ),
                        ),
                        title: Text(
                          list[index]['init_observation'],
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: list == null ? 0 : list.length,
            );
          },
        ),
      ),
    );
  }
}
