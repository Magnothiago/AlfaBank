import 'package:alfa_banck/components/editorUsuario.dart';
import 'package:alfa_banck/modules/usuario.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final TextEditingController _campoNomeController = TextEditingController();
  final TextEditingController _campoCpfController = TextEditingController();
  final TextEditingController _campoEmailController = TextEditingController();
  final TextEditingController _campoTelefoneController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Usuário"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EditorUsuario(
              controller: this._campoNomeController,
              dica: "João Silva",
              rotulo: "Nome Completo",
              icon: Icon(Icons.account_circle_outlined),
              tipoEntrada: TextInputType.name,
            ),
            EditorUsuario(
              controller: this._campoCpfController,
              dica: "123.123.123-00",
              rotulo: "CPF",
              icon: Icon(Icons.credit_card),
              tipoEntrada: TextInputType.number,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                child: TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'email@email.com',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return (value != null && EmailValidator.validate(value))
                        ? null
                        : "coloque um e-mail válido";
                  },
                ),
              ),
            ),
            EditorUsuario(
              controller: this._campoTelefoneController,
              dica: "(00) 00000-0000",
              rotulo: "Telefone",
              icon: Icon(Icons.phone_android),
              tipoEntrada: TextInputType.phone,
            ),
            RaisedButton(
              child: Text("Cadastrar"),
              onPressed: () {
                var nome = this._campoNomeController.text;
                var cpf = this._campoCpfController.text;
                var email = this._campoEmailController.text;
                var telefone = this._campoTelefoneController.text;

                Usuario usuario = Usuario(nome, cpf, email, telefone);

                print(usuario.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
