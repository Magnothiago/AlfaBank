import 'package:alfa_banck/src/modules/transferencia.dart';
import 'package:flutter/material.dart';
import '../components/item_transferencia.dart';
import 'formulario_transferencia.dart';

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> listatransferencias = [];
  @override
  _ListaTransferenciaState createState() => _ListaTransferenciaState();
}

class _ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    // widget.listatransferencias.add(Transferencia(250, '123456'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tranferências'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.listatransferencias.length,
        itemBuilder: (context, indice) {
          var transferencia = widget.listatransferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );
          future.then((listaTransferenciaRecebida) {
            if (listaTransferenciaRecebida == null ||
                listaTransferenciaRecebida.valor == null ||
                listaTransferenciaRecebida.conta == null) {
              return;
            }
            setState(() {
              widget.listatransferencias.add(listaTransferenciaRecebida);
            });
          });
        },
      ),
    );
  }
}
