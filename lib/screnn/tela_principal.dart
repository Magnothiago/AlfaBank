import 'package:flutter/material.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [],
        leading: Icon(null),
        title: Text(
          "Titulo da pagina",
          style: TextStyle(fontFamily: "Courier", fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [],
      ),
    );
  }
}