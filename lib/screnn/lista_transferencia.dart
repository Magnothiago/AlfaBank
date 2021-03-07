import 'file:///C:/Users/djthi/IdeaProjects/alfa_banck/lib/screnn/formulario_transferencia.dart';
import 'file:///C:/Users/djthi/IdeaProjects/alfa_banck/lib/modules/transferencia.dart';
import 'package:flutter/material.dart';
import '../components/item_transferencia.dart';

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
            if(listaTransferenciaRecebida == null
                || listaTransferenciaRecebida.valor == null
                || listaTransferenciaRecebida.conta ==null){
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
