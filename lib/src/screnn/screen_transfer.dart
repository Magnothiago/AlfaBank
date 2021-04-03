import 'package:flutter/material.dart';

import '../components/edit.dart';
import '../modules/transferencia.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController controladorCampoValor = TextEditingController();
  static const String routName = "screen_transferencia";
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
            TextButton(
              onPressed: () {
                var conta = controladorCampoNumeroConta.text;
                var valor = controladorCampoValor.text;
                Transferencia transferencia =
                    new Transferencia(double.tryParse(valor), conta);
                Navigator.pop(context, transferencia);
              },
              child: Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
