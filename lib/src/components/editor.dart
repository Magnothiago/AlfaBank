import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  TextEditingController controller;
  final String rotulo;
  final String dica;
  TextInputType tipoEditor;

  Editor ({this.controller, this.rotulo,this.dica,this.tipoEditor});
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
          labelText: this.rotulo,
          hintText: this.dica,
        ),
        keyboardType: this.tipoEditor,
      ),
      );
  }
}
