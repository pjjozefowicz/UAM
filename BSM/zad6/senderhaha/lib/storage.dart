import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';

class Storage {
  Storage() {
    print('siema');
    getPermissions();
//    getContacts();
  }

  void getPermissions() async {
    await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    Directory dir = await getExternalStorageDirectory();
    print(dir);
    String path = dir.path;
    File file = File('$path/contacts.txt');
    String contactsString = await file.readAsString();

    print(contactsString);
  }

  void getContacts() async {
    Directory dir = await getExternalStorageDirectory();
    String path = dir.path;
    File file = File('$path/contacts.txt');

    String contactsString = await file.readAsString();

    print(contactsString);
  }
}