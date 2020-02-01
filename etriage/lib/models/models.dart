class Patient {
  String age;
  String bp;
  String capillaryRefill;
  String firstName;
  String initObservation;
  String lastName;
  String locations;
  String priorityTag;
  String pulse;
  String qrToken;
  String rr;
  String tagDescription;

  Patient(
      {this.age,
      this.bp,
      this.capillaryRefill,
      this.firstName,
      this.initObservation,
      this.lastName,
      this.locations,
      this.priorityTag,
      this.pulse,
      this.qrToken,
      this.rr,
      this.tagDescription});

  Patient.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    bp = json['bp'];
    capillaryRefill = json['capillary_refill'];
    firstName = json['first_name'];
    initObservation = json['init_observation'];
    lastName = json['last_name'];
    locations = json['locations'];
    priorityTag = json['priority_tag'];
    pulse = json['pulse'];
    qrToken = json['qr_token'];
    rr = json['rr'];
    tagDescription = json['tag_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['bp'] = this.bp;
    data['capillary_refill'] = this.capillaryRefill;
    data['first_name'] = this.firstName;
    data['init_observation'] = this.initObservation;
    data['last_name'] = this.lastName;
    data['locations'] = this.locations;
    data['priority_tag'] = this.priorityTag;
    data['pulse'] = this.pulse;
    data['qr_token'] = this.qrToken;
    data['rr'] = this.rr;
    data['tag_description'] = this.tagDescription;
    return data;
  }
}

class Responder {
  final String username;
  Responder(this.username);

  @override
  String toString() {
    return "Responder {usename: ${this.username}";
  }

  Responder.fromJson(Map<String, dynamic> json)
      : username = (json["username"] ?? "");
}

class TriigeCredential {
  final String token;

  TriigeCredential(this.token);

  @override
  String toString() {
    return "TriigeCredential{token: ${this.token}}";
  }

  TriigeCredential.fromJson(Map<String, dynamic> json) : token = json["token"];
}

class TriigeLocation {
  final Map<String, dynamic> t1;
  final Map<String, dynamic> t2;
  final Map<String, dynamic> t3;
  final Map<String, dynamic> t4;
  TriigeLocation(this.t1, this.t2, this.t3, this.t4);

  @override
  String toString() {
    return "Responder {t1: ${this.t1}, " +
        "t2: ${this.t2}, " +
        "t3: ${this.t3}, " +
        "t4: ${this.t4} }";
  }

  TriigeLocation.fromJson(Map<String, dynamic> json)
      : t1 = (json['t1']),
        t2 = (json['t2']),
        t3 = (json['t3']),
        t4 = (json['t4']);
}

///****************** Error Handlers ********************

class PatientNotFound implements Exception {
  String errorMessage() => "Patient not found!";
  String toString() => errorMessage();
}

class ResponderNotFound implements Exception {
  String errorMessage() => "Responder profile not found!";
  String toString() => errorMessage();
}

class SomethingWentWrong implements Exception {
  String errorMessage() => "Something went wrong!";
  String toString() => errorMessage();
}

class CredentialExpired implements Exception {
  String errorMessage() => "Credential expired, user must log in again!";
  String toString() => errorMessage();
}

class UpdateError implements Exception {
  final String responseMessage;
  UpdateError(this.responseMessage);
  String errorMessage() => "*** Failed to update/add user: $responseMessage\n";
  String toString() => errorMessage();
}
