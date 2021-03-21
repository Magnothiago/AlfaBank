import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String _nome;
  Color _corBotao;
  Color corTexto;
  Function aoClicar;

  Button(this._corBotao, this.corTexto, this._nome, this.aoClicar);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: TextButton(
          child: Text(
            this._nome,
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(
            primary: _corBotao,
            backgroundColor: this._corBotao,
          ),
          onPressed: () {
            this.aoClicar();
          },
        ),
      ),
    );
  }
}
