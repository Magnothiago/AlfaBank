import 'package:alfa_banck/editor.dart';
import 'package:alfa_banck/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova transferência'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: this.controladorCampoNumeroConta,
              rotulo: 'Numero da conta',
              dica: '000',
              tipoEditor: TextInputType.number,
            ),
            Editor(
              controller: this.controladorCampoValor,
              rotulo: 'Valor',
              dica: '000',
              tipoEditor: TextInputType.number,
            ),
            RaisedButton(
              onPressed: () {
                var conta = controladorCampoNumeroConta.text;
                var valor = controladorCampoValor.text;
                Transferencia transferencia =
                    new Transferencia(double.tryParse(valor), conta);
                // if(transferencia != null){
                //   Navigator.pop(context);
                // }
                Navigator.pop(context,transferencia);
              },
              child: Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }
}
