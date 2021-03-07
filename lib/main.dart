import 'file:///C:/Users/djthi/IdeaProjects/alfa_banck/lib/screnn/formulario_transferencia.dart';
import 'package:alfa_banck/screnn/login.dart';
import 'package:flutter/material.dart';
import 'screnn/lista_transferencia.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.redAccent,
        )
      ),
      home: new Login(),
    );
  }
}
