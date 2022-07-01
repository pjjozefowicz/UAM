import 'contacts.dart';
import 'storage.dart';
import 'package:contacts_service/contacts_service.dart';

class Controller {
  static Future<bool> getPermissions() async {
    bool contactsPermission = await Contacts.getContactsPermission();
    bool storagePermission = await Storage.getStoragePermission();

    return contactsPermission && storagePermission;
  }

  static Future<void> getAndSaveContacts() async {
    Iterable<Contact> contacts = await Contacts.getContacts();

    String contactsString = parseContacts(contacts);

    Storage.saveToStorage(contactsString);
  }

  static String parseContacts(Iterable<Contact> contacts) {
    String contactsString = '';

    contacts.forEach((Contact contact) {
      String phonesString = '';
      Iterable<Item> phones = contact.phones;
      phones.forEach((Item phone) {
        String phoneString = phone.value;
        phonesString += '$phoneString ';
      });

      String displayName = contact.displayName;
      contactsString += '$displayName - $phonesString \n';
    });
    print(contactsString);
    return contactsString;
  }
}