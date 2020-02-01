import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';


///************* Encrypted Token Generator ****************

class TokenGenerator {
  static final Random _random = Random.secure();
  static String createCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }
}

///******************** HTTP Requests ********************

var client = new http.Client();

Future<http.Response> getTriige(String url, String endpoint) {
  return client.get(url + endpoint);
}

Future<http.Response> postTriige(String url, dynamic body) async {
  var encodedBody = jsonEncode(body);
  var result = await client.post(url,
      headers: {"Content-Type": "application/json"}, body: encodedBody);
  return result;
}

/// POST w/ an "endpoint" parameter
Future<http.Response> postTriigeEP(
    String url, String endpoint, dynamic body) async {
  var encodedBody = jsonEncode(body);
  var result = await client.post(url + endpoint,
      headers: {"Content-Type": "application/json"}, body: encodedBody);
  return result;
}

///************* GET/POST Requests Functions ***************

Future<Patient> getPatient(String url, String authToken, String qrToken) async {
  Response response;
  Dio dio = new Dio();
  response = await dio.post(
    url,
    data: {
      "qr_token": qrToken,
      "token": authToken,
    },
  );
  if (response.statusCode == 200) {
    print('***** FIRST_NAME: ' + response.data['first_name']);
    var parsedJson = json.decode(response.data);
    var data = Patient.fromJson(parsedJson);
    return data;
  } else if (response.statusCode == 400) {
    throw PatientNotFound();
  } else {
    throw SomethingWentWrong();
  }
}

void addPatient(
    String url,
    String qrToken,
    String authToken,
    String priorityTag,
    String tagDescription,
    String firstName,
    String lastName,
    String age,
    String rr,
    String pulse,
    String capillaryRefill,
    String bp,
    String initObservation,
    List locations) async {
  var response = await postTriigeEP(url, "/addPatient", {
    "qr_token": qrToken,
    "token": authToken,
    "priority_tag": priorityTag,
    "tag_description": tagDescription,
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "rr": rr,
    "pulse": pulse,
    "capillary_refill": capillaryRefill,
    "bp": bp,
    "init_observation": initObservation,
    "locations": locations,
  });
  if (response.statusCode == 200) {
    print('PATIENT DATA ADDED SUCCESSFULLY!');
  } else if (response.statusCode == 400) {
    throw ErrorDescription('Something went wrong in the POST request');
  } else {
    throw SomethingWentWrong();
  }
}

void editPatient(
    String url,
    String qrToken,
    String authToken,
    String priorityTag,
    String tagDescription,
    String firstName,
    String lastName,
    String age,
    String rr,
    String pulse,
    String capillaryRefill,
    String bp,
    String initObservation,
    List locations) async {
  var response = await postTriigeEP(url, "/editPatient", {
    "qr_token": qrToken,
    "token": authToken,
    "priority_tag": priorityTag,
    "tag_description": tagDescription,
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "rr": rr,
    "pulse": pulse,
    "capillary_refill": capillaryRefill,
    "bp": bp,
    "init_observation": initObservation,
    "locations": locations,
  });
  if (response.statusCode == 200) {
    print('PATIENT DATA EDITED SUCCESSFULLY!');
  } else if (response.statusCode == 400) {
    throw ErrorDescription('Something went wrong in the POST request');
  } else {
    throw SomethingWentWrong();
  }
}

Future<List> getPatientByTag(String urlWithEndPoint, String authToken) async {
  var response = await postTriige(urlWithEndPoint, {
    "token": authToken,
  });
  if (response.statusCode == 200) {
    List patients = jsonDecode(response.body) as List;
    return patients;
  } else if (response.statusCode == 400) {
    throw PatientNotFound();
  } else {
    throw SomethingWentWrong();
  }
}

Future<Responder> getResponderProfile(String url, String authToken) async {
  var response = await postTriige(url + "/respondInfo", {
    "token": authToken,
  });
  if (response.statusCode == 200) {
    var responderProfile = jsonDecode(response.body);
    return Responder.fromJson(responderProfile);
  } else if (response.statusCode == 400) {
    throw ResponderNotFound();
  } else {
    throw SomethingWentWrong();
  }
}

Future<TriigeCredential> login(
    String url, String username, String password) async {
  var response = await postTriige(url + "/login", {
    "username": username,
    "password": password,
  });
  if (response.statusCode == 200) {
    var authData = jsonDecode(response.body);
    return TriigeCredential.fromJson(authData);
  } else if (response.statusCode == 400) {
    throw ResponderNotFound();
  } else {
    throw SomethingWentWrong();
  }
}

Future<TriigeLocation> getLocations(String url, String authToken) async {
  var response = await postTriige(url + "/getLocations", {"token": authToken});
  if (response.statusCode == 200) {
    var locations = jsonDecode(response.body);
    print("LOCATIONS FROM SERVICES: " + locations.toString());
    return TriigeLocation.fromJson(locations);
  } else if (response.statusCode == 400) {
    throw ResponderNotFound();
  } else {
    throw SomethingWentWrong();
  }
}
