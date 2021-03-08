import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class EditorUsuario extends StatelessWidget {
  TextEditingController controller;
  final String rotulo;
  final String dica;
  final Icon icon;
  TextInputType tipoEntrada;

  EditorUsuario(
      {this.controller, this.rotulo, this.dica, this.icon, this.tipoEntrada});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: TextFormField(
          autocorrect: true,
          autofocus: true,
          decoration: InputDecoration(
            hintText: this.dica,
            labelText: this.rotulo,
            prefixIcon: this.icon,
          ),
          autovalidateMode: AutovalidateMode.always,
          keyboardType: this.tipoEntrada,
          controller: this.controller,
        ),
      ),
    );
  }
}
