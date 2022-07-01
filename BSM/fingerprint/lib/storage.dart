import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordStorage {
  final storage = new FlutterSecureStorage();

  void savePassword(String password) async {
    await storage.write(key: 'password', value: password);
  }

  Future<bool> checkIfPasswordExists() async {
    var password = await storage.read(key: 'password');
    return password != null;
  }

  void resetPassword() async {
    storage.delete(key: 'password');
  }

  Future<bool> checkPassword(String password) async {
    String passw = await storage.read(key: 'password');
    return passw == password;
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    var isPasswordCorrect = await checkPassword(oldPassword);
    if (!isPasswordCorrect) {
      return false;
    }
    savePassword(newPassword);
    return true;
  }
}

class NotesStorage {
  final storage = new FlutterSecureStorage();

  void saveNote(String note) async {
    storage.write(key: 'note', value: note);
  }

  Future<String> getNote() async {
    String note = await storage.read(key: 'note');
    return note;
  }

  void deleteNote() async {
    storage.delete(key: 'note');
  }
}
