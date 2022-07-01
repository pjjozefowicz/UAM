import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:steel_crypt/steel_crypt.dart';

class PasswordStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _passwordFile async {
    final path = await _localPath;
    return File('$path/ignore_this.txt');
  }

  Future<File> get _passwordSaltFile async {
    final path = await _localPath;
    return File('$path/password_salt.txt');
  }

  void savePassword(String password) async {
    final file = await _passwordFile;
    final saltFile = await _passwordSaltFile;
    final passCrypt = PassCrypt('SHA-512/HMAC/PBKDF2');
    final cryptKey = CryptKey();

    final String salt = cryptKey.genDart(16);
    final String hash = passCrypt.hashPass(salt, password);
    print(salt);
    print(hash);
    saltFile.writeAsString('$salt');
    file.writeAsString('$hash');
  }

  Future<bool> checkIfPasswordExists() async {
    try {
      final file = await _passwordFile;
      String passwordHash = await file.readAsString();
      return passwordHash.length > 0;
    } catch (e) {
      return false;
    }
  }

  void resetPassword() async {
    final passwordFile = await _passwordFile;
    final saltFile = await _passwordSaltFile;
    passwordFile.deleteSync();
    saltFile.deleteSync();
  }

  Future<bool> checkPassword(String password) async {
    try {
      final passFile = await _passwordFile;
      final saltFile = await _passwordSaltFile;
      final passCrypt = PassCrypt('SHA-512/HMAC/PBKDF2');

      String salt = await saltFile.readAsString();
      String hased = await passFile.readAsString();

      return passCrypt.checkPassKey(salt, password, hased);
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      var passwordCorrect = await checkPassword(oldPassword);
      if (!passwordCorrect) {
        return false;
      }

      savePassword(newPassword);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class NotesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _noteFile async {
    final path = await _localPath;
    return File('$path/note.txt');
  }

  Future<File> get _noteSaltFile async {
    final path = await _localPath;
    return File('$path/noteSalt.txt');
  }

  Future<File> get _initVectorFile async {
    final path = await _localPath;
    return File('$path/init_vector_file.txt');
  }

  void saveNote(String note, String password) async {
    final file = await _noteFile;
    final saltFile = await _noteSaltFile;
    final initVectorFile = await _initVectorFile;
    final passCrypt = PassCrypt('SHA-512/HMAC/PBKDF2');
    final cryptKey = CryptKey();

    String salt = cryptKey.genDart(16);
    String iv = cryptKey.genDart(16);
    String key = passCrypt.hashPass(salt, password);

    final aesCrypt = AesCrypt(key);
    final String encrypted = aesCrypt.encrypt(note, iv);
    print("saveNote: Note: $note");
    print("saveNote: EncryptedNote: $encrypted");

    initVectorFile.writeAsStringSync('$iv');
    saltFile.writeAsStringSync('$salt');
    file.writeAsString('$encrypted');
  }

  Future<String> getNote(String password) async {
    try {
      final file = await _noteFile;
      final saltFile = await _noteSaltFile;
      final initVectorFile = await _initVectorFile;
      final passCrypt = PassCrypt('SHA-512/HMAC/PBKDF2');

      String iv = await initVectorFile.readAsString();
      String salt = await saltFile.readAsString();
      String encrypted = await file.readAsString();
      print("getNote: EncryptedNote: $encrypted");

      String key = passCrypt.hashPass(salt, password);

      final aesCrypt = AesCrypt(key);
      final String note = aesCrypt.decrypt(encrypted, iv);
      print("getNote: Note: $note");

      return note;
    } catch (e) {
      return "Brak notatek";
    }
  }

  void deleteNote() async {
    final file = await _noteFile;
    final saltFile = await _noteSaltFile;
    final initVectorFile = await _initVectorFile;

    initVectorFile.delete();
    file.delete();
    saltFile.delete();
  }
}
