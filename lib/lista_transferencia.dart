import 'package:alfa_banck/formulario_transferencia.dart';
import 'package:alfa_banck/transferencia.dart';
import 'package:flutter/material.dart';
import 'item_transferencia.dart';

class listaTransferencia extends StatefulWidget {

  final List<Transferencia> listatransferencias = List();
  @override
  _listaTransferenciaState createState() => _listaTransferenciaState();
}

class _listaTransferenciaState extends State<listaTransferencia> {
  @override
  Widget build(BuildContext context) {

    // widget.listatransferencias.add(Transferencia(250, '123456'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Lista de tranferências'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.listatransferencias.length,
        itemBuilder: (context, indice){
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
            setState(() {
              widget.listatransferencias.add(listaTransferenciaRecebida);
            });
          });
        },
      ),
    );
  }
}
