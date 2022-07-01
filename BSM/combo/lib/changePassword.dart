import 'package:flutter/material.dart';
import 'storage.dart';

class ChangePasswordScreen extends StatefulWidget {
  final PasswordStorage passwordStorage;
  final NotesStorage noteStorage;

  ChangePasswordScreen(
      {Key key, @required this.passwordStorage, @required this.noteStorage})
      : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _oldPassword;
  String _newPassword;

  setOldPassword(String password) {
    _oldPassword = password;
  }

  setNewPassword(String password) {
    _newPassword = password;
  }

  void _changePassword() async {
    var changed =
        await widget.passwordStorage.changePassword(_oldPassword, _newPassword);
    if (changed) {
      String note = await widget.noteStorage.getNote();
      widget.noteStorage.saveNote(note);
    }
    String alertTitle = changed ? 'Zmieniono hasło' : 'Złe hasło';
    String alertMsg = changed ? '' : '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(alertTitle),
            content: Text(alertMsg),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wpisz hasło')),
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (String password) {
                    setOldPassword(password);
                  },
                  decoration: InputDecoration(
                    hintText: 'Wpisz stare hasło',
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (String password) {
                    setNewPassword(password);
                  },
                  decoration: InputDecoration(
                    hintText: 'Wpisz nowe hasło',
                  ),
                ),
                RaisedButton(
                    child: Text('Zapisz hasło'), onPressed: _changePassword)
              ]),
        ),
      ),
    );
  }
}
