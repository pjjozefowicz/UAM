import 'package:flutter/material.dart';

import 'login.dart';
import 'setPassword.dart';
import 'storage.dart';
import 'changePassword.dart';

void main() {
  runApp(MaterialApp(
      title: 'Bezpieczny Notatnik',
      home: InitializeApp(storage: PasswordStorage()),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) =>
            LoginScreen(storage: PasswordStorage()),
        '/setPassword': (BuildContext context) =>
            SetPasswordScreen(storage: PasswordStorage()),
        '/changePassword': (BuildContext context) => ChangePasswordScreen(
              passwordStorage: PasswordStorage(),
              noteStorage: NotesStorage(),
            ),
      }));
}

class InitializeApp extends StatefulWidget {
  final PasswordStorage storage;

  InitializeApp({Key key, @required this.storage}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<InitializeApp> {
  @override
  void initState() {
    super.initState();
    widget.storage.checkIfPasswordExists().then((bool value) {
      var route = value ? '/login' : '/setPassword';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Text(''),
    );
  }
}
