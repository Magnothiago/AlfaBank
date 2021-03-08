import 'package:flutter/material.dart';
import '../modules/transferencia.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferencia transferencia;
  // double valor;
  // String conta;
  ItemTransferencia(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text("R\$ ${this.transferencia.valor.toString()}"),
        subtitle: Text('Conta: ${this.transferencia.conta}'),
      ),
    );
  }
}
