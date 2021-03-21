import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFildLogin extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixconData;
  final bool ocultarTexto;
  final Function onChanged;
  final TextInputType tipoTeclado;
  final TextEditingController controller;
  final List<TextInputFormatter> formatters;

  TextFildLogin(
      {this.hintText,
        this.prefixIconData,
        this.suffixconData,
        this.ocultarTexto,
        this.onChanged,
        this.tipoTeclado,
        this.controller,
        this.formatters
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: formatters,
      controller: controller,
      obscureText: ocultarTexto,
      onChanged: this.onChanged,
      style: TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
      keyboardType: this.tipoTeclado,
      decoration: InputDecoration(
        labelText: this.hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.red,
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
        suffixIcon: Icon(
          suffixconData,
          size: 18,
          color: Colors.red,
        ),
        labelStyle: TextStyle(color: Colors.red),
        focusColor: Colors.red,
      ),
    );
  }
}
