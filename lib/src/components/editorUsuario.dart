import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class EditorUsuario extends StatelessWidget {
  TextEditingController controller;
  final String rotulo;
  final String dica;
  final Icon icon;
  TextInputType tipoEntrada;
  List<TextInputFormatter> formatters;
  final bool obscureText;

  EditorUsuario(
      {this.controller,
      this.rotulo,
      this.dica,
      this.icon,
      this.tipoEntrada,
      this.formatters,
      this.obscureText
      });

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
          inputFormatters: this.formatters,
          obscureText: obscureText != null ? obscureText : false,
        ),
      ),
    );
  }
}
