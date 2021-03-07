import 'package:alfa_banck/formulario_transferencia.dart';
import 'package:flutter/material.dart';
import 'lista_transferencia.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new listaTransferencia(),
    );
  }
}
