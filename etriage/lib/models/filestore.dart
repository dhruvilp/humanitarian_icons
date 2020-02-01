import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> _appPath() async {
  return (await getApplicationDocumentsDirectory()).path;
}

Future<File> storedFile(String name) async {
  var path = (await _appPath()) + "/" + name;
  var f = File(path);
  if (!(await f.exists())) {
    await f.create();
  }
  return f;
}

Future<File> storedCredentialFile() => storedFile("credential.json");

Future<String> getStoredCredential() async {
  var credFile = await storedCredentialFile();
  var contents = await credFile.readAsString();
  if (contents == "") {
    return null;
  }
  return contents;
}

void setStoredCredential(String cred) async {
  var credFile = await storedCredentialFile();
  await credFile.writeAsString(cred);
}
