import 'package:alfa_banck/screnn/formulario_cadastro_user.dart';
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
          )),
      home: Login(),
    );
  }
}
