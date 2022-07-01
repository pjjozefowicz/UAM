import 'package:flutter/material.dart';
import 'storage.dart';

class SetPasswordScreen extends StatefulWidget {
  final PasswordStorage storage;

  SetPasswordScreen({Key key, @required this.storage}) : super(key: key);

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}


class _SetPasswordScreenState extends State<SetPasswordScreen> {
  String _password;

  changePassword(String password) {
    _password = password;
  }

  void _savePassword() async {
    setState(() {
      widget.storage.savePassword(_password);
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  body() {
    return [
      TextField(
        textAlign: TextAlign.center,
        obscureText: true,
        onChanged: (String password) {changePassword(password);},
        decoration: InputDecoration(
          hintText: 'Wpisz hasło',
        ),
      ),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text('Zapisz hasło'),
        onPressed: _savePassword
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50.0),
              child: Text(
                'Zarejestruj hasło',
                style: TextStyle(
                  fontSize: 26.0
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (String password) {changePassword(password);},
              decoration: InputDecoration(
                hintText: 'Wpisz hasło',
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Zapisz hasło'),
              onPressed: _savePassword
            )
          ]
        )
      )
    );
  }
}
