import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:location/location.dart';

import '../../defaults.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../style.dart';
import 'LoadingIndicator.dart';

const languages = const [
  const Language('English', 'en_US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class PatientProfileData extends StatefulWidget {
  PatientProfileData({
    this.qrToken,
    this.authToken,
  });

  final String qrToken;
  final String authToken;

  @override
  _PatientProfileDataState createState() => _PatientProfileDataState();
}

class _PatientProfileDataState extends State<PatientProfileData> {
  static const triageTags = <String>['T1', 'T2', 'T3', 'T4'];

  final List<DropdownMenuItem<String>> _tagItems = triageTags
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  ///*************** Voice Recognition Variables ***************
  var selected_controller = TextEditingController();
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  Language selectedLang = languages.first;
  double lat;
  double long;

  @override
  void initState() {
    _fetchPatientData();
    activateSpeechRecognizer();
    _getCurrentLocation();
    return super.initState();
  }

  ///********************* GET LOCATION ***************************

  Location _locationService = new Location();
  LocationData location;

  _getCurrentLocation() async {
    location = await _locationService.getLocation();
    try {
      print(
          '***********\n LONGITUDE: ${location.longitude} \n LATITUDE: ${location.latitude}');
      lat = location.latitude;
      long = location.longitude;
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        print(e.message);
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        print(e.message);
      }
      location = null;
    }
  }

  ///*******************************************************************
  ///                   SPEECH TO TEXT FUNCTIONS
  ///*******************************************************************

  void start() => _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          print('_MyAppState.start => result $result');
          setState(() {
            _isListening = result;
          });
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() => _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    print("onRec stated");
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() {
      selected_controller.text = text;
    });
  }

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() {
    print("error");
    activateSpeechRecognizer();
  }

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('en_US').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  ///*******************************************************************
  ///                     HTTP REQUESTS + BUILD
  ///*******************************************************************

  String initTagValue;
  String selectedTag;
  Dio dio = new Dio();
  bool _hasData = false;

  Future _fetchPatientData() async {
    Response kResponse = await dio.post(API + '/getPatient',
        data: {"qr_token": widget.qrToken, "token": widget.authToken});
    print("STATUS CODE: ${kResponse.statusCode}");

    if (kResponse.statusCode == 200) {
      initTagValue = kResponse.data['priority_tag'] != null
          ? kResponse.data['priority_tag']
          : '';
      priority_tag_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['priority_tag'] : '');
      tag_description_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['tag_description'] : '');
      first_name_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['first_name'] : '');
      last_name_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['last_name'] : '');
      age_controller = TextEditingController(
          text: kResponse != null ? "${kResponse.data['age']}" : '');
      rr_controller = TextEditingController(
          text: kResponse != null ? "${kResponse.data['rr']}" : '');
      pulse_controller = TextEditingController(
          text: kResponse != null ? "${kResponse.data['pulse']}" : '');
      capillary_refill_controller = TextEditingController(
          text:
              kResponse != null ? "${kResponse.data['capillary_refill']}" : '');
      bp_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['bp'] : '');
      init_observation_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['init_observation'] : '');
      locations_controller = TextEditingController(
          text: kResponse != null ? kResponse.data['locations'] : '');
      _getCurrentLocation();

      return kResponse;
    } else if (kResponse.statusCode == 400) {
      throw PatientNotFound();
    } else {
      throw SomethingWentWrong();
    }
  }

  var qr_token_controller = TextEditingController();
  var priority_tag_controller = TextEditingController();
  var tag_description_controller = TextEditingController();
  var first_name_controller = TextEditingController();
  var last_name_controller = TextEditingController();
  var age_controller = TextEditingController();
  var rr_controller = TextEditingController();
  var pulse_controller = TextEditingController();
  var capillary_refill_controller = TextEditingController();
  var bp_controller = TextEditingController();
  var init_observation_controller = TextEditingController();
  var locations_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Edit Patient Profile'),
          actions: <Widget>[
            new Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  size: 20.0,
                ),
                onPressed: () {
                  if (_hasData) {
                    List currentLocations = [
                      {"lat": "$lat", "long": "$long"}
                    ];
                    editPatient(
                        API,
                        widget.qrToken,
                        widget.authToken,
                        priority_tag_controller.text,
                        tag_description_controller.text,
                        first_name_controller.text,
                        last_name_controller.text,
                        age_controller.text,
                        rr_controller.text,
                        pulse_controller.text,
                        capillary_refill_controller.text,
                        bp_controller.text,
                        init_observation_controller.text,
                        currentLocations);
                  } else {
                    List currentLocations = [
                      {"lat": "$lat", "long": "$long"}
                    ];
                    addPatient(
                        API,
                        widget.qrToken,
                        widget.authToken,
                        priority_tag_controller.text,
                        tag_description_controller.text,
                        first_name_controller.text,
                        last_name_controller.text,
                        age_controller.text,
                        rr_controller.text,
                        pulse_controller.text,
                        capillary_refill_controller.text,
                        bp_controller.text,
                        init_observation_controller.text,
                        currentLocations);
                  }
//                _showDialog(context);
                  Navigator.pop(context);
                },
                splashColor: pink,
                color: white,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: FutureBuilder(
            future: _fetchPatientData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Invalid API URL');
                case ConnectionState.waiting:
                  return new Center(child: new LoadingIndicator());
                default:
                  var response = snapshot.data;
                  if (snapshot.hasData) {
                    _hasData = true;
                    return customForm(response);
                  } else {
                    _hasData = false;
                    return customForm(response);
                  }
              }
            },
          ),
        ),
        floatingActionButton: Visibility(
          visible: _isListening,
          child: FloatingActionButton(
            onPressed: () {
              print("Hit stopped");
              _isListening ? () => cancel() : null;
              _isListening ? () => stop() : null;
              _isListening = false;
            },
            child: Icon(Icons.stop),
            splashColor: white,
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: white,
          ),
        ));
  }

  /// *****************************************************************************
  ///                            CUSTOM FORM WIDGET
  /// *****************************************************************************

  Widget customForm(Response patient) {
    return ListView(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(0.0),
          leading: CircleAvatar(
            child: Icon(Icons.person),
            maxRadius: 25.0,
          ),
          title: Text(
            "Patient ID:",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: SelectableText(
            (patient == null) ? widget.qrToken : patient.data['qr_token'],
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
            maxLines: null,
            enableInteractiveSelection: true,
          ),
        ),
        ListTile(
          leading: Icon(
            GroovinMaterialIcons.tag,
            color: selectedTag == null
                ? initTagValue == 'T1'
                    ? red
                    : (initTagValue == 'T2'
                        ? yellow
                        : (initTagValue == 'T3'
                            ? green
                            : (initTagValue == 'T4' ? black : grey)))
                : (selectedTag == 'T1'
                    ? red
                    : (selectedTag == 'T2'
                        ? yellow
                        : (selectedTag == 'T3'
                            ? green
                            : (selectedTag == 'T4' ? black : grey)))),
            size: 30.0,
          ),
          title: Text(
            'Priority Tag',
            style: TextStyle(
              fontSize: 18.0,
              color: black,
            ),
          ),
          trailing: DropdownButton(
            style: TextStyle(
              fontSize: 18.0,
              color: black,
            ),
            value: selectedTag == null ? initTagValue : selectedTag,
            hint: Text('Select Tag'),
            onChanged: ((val) {
              setState(() {
                selectedTag = val;
                priority_tag_controller.text = val;
              });
            }),
            items: _tagItems,
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = tag_description_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Tag Description'),
              keyboardType: TextInputType.text,
              controller: tag_description_controller,
              maxLines: null,
              minLines: null,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = first_name_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              keyboardType: TextInputType.text,
              controller: first_name_controller,
              maxLines: null,
              minLines: null,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = last_name_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              controller: last_name_controller,
              keyboardType: TextInputType.text,
              maxLines: null,
              minLines: null,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = age_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              controller: age_controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = rr_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'RR'),
              controller: rr_controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = pulse_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Pulse'),
              controller: pulse_controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = capillary_refill_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Capillary Refill'),
              controller: capillary_refill_controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = bp_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'BP',
                hintText: '80/120',
              ),
              controller: bp_controller,
              keyboardType: TextInputType.text,
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print("Hit double tap");
            start();
            selected_controller = init_observation_controller;
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Init Observations',
              ),
              controller: init_observation_controller,
              keyboardType: TextInputType.text,
              maxLines: null,
              minLines: null,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  @override
  void dispose() {
    qr_token_controller.dispose();
    priority_tag_controller.dispose();
    tag_description_controller.dispose();
    first_name_controller.dispose();
    last_name_controller.dispose();
    age_controller.dispose();
    rr_controller.dispose();
    pulse_controller.dispose();
    capillary_refill_controller.dispose();
    bp_controller.dispose();
    init_observation_controller.dispose();
    locations_controller.dispose();
    selected_controller.dispose();
    super.dispose();
  }

  ///************************************************************************
  ///                           TEST FUNCTION
  ///************************************************************************

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Patient Record'),
          content: Text(
            'P_TAG: ${priority_tag_controller.text}\n'
            'P_DESC: ${tag_description_controller.text}\n'
            'F_NAME: ${first_name_controller.text}\n'
            'L_NAME: ${last_name_controller.text}\n',
          ),
        );
      },
    );
  }
}
