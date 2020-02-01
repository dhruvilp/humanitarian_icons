import 'dart:async';

import 'package:meta/meta.dart';

import '../defaults.dart';
import 'filestore.dart';
import '../services/services.dart';

class User {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var cred = await login(API, username, password);
    setStoredCredential(cred.token);
    if (cred != null) {
      print('*** AUTH TOKEN: ' + cred.token);
      return cred.token;
    }
  }

  Future<void> deleteToken() async {
    var credFile = await storedCredentialFile();
    await credFile.delete();
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    await getStoredCredential();
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    var credFile = await storedCredentialFile();
    var contents = await credFile.readAsString();
    if (contents != "") {
      return true;
    }
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
