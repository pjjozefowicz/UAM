import 'package:simple_permissions/simple_permissions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage {
  static Future<bool> getStoragePermission() async {
    bool isPermitted = await checkPermission();

    if (!isPermitted) {
      bool gotPermission = await askForPermission();
      return gotPermission;
    } else {
      return isPermitted;
    }
  }

  static Future<bool> checkPermission() async {
    bool permitted = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);

    return permitted;
  }

  static Future<bool> askForPermission() async {
    PermissionStatus permissionStatus = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    return permissionStatus == PermissionStatus.authorized;
  }

  static Future<void> saveToStorage(String contacts) async {
    final file = await _file();

    print("ZApisuje");

    return file.writeAsStringSync(contacts);
  }
  
  
  static Future<String> dirPath() async {
    Directory dir = await getExternalStorageDirectory();
    print(dir.path);
    return dir.path;
  }
  
  static Future<File> _file() async {
    final path = await dirPath();
    return File('$path/contacts.txt');
  }
}