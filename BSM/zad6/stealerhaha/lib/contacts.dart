import 'package:contacts_service/contacts_service.dart';
import 'package:simple_permissions/simple_permissions.dart';

class Contacts {

  static Future<bool> getContactsPermission() async {
    bool isPermitted = await checkPermissions();

    if (!isPermitted) {
      bool gotPermission = await askForPermission();
      return gotPermission;
    } else {
      return isPermitted;
    }
  }

  static Future<bool> checkPermissions() async {
    Permission permission = Permission.ReadContacts;

    bool permitted = await SimplePermissions.checkPermission(permission);

    return permitted;
  }


  static Future<bool> askForPermission() async {
    PermissionStatus status = await SimplePermissions.requestPermission(Permission.ReadContacts);
    return status == PermissionStatus.authorized;
  }

  static Future<Iterable<Contact>> getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();

    return contacts;
  }
}