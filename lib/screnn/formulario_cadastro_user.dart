import 'package:alfa_banck/components/editorUsuario.dart';
import 'package:alfa_banck/modules/usuario.dart';
import 'package:email_validator/email_validator.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/services.dart';

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

  bool validarDados(nome, cpf, email, telefone) {
    return (nome != null &&
            CPF.isValid(cpf) &&
            email != null &&
            telefone != null)
        ? true
        : false;
  }

  Future<void> _showDialog() async {
    return (BuildContext context) {
      return ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Deu tudo certo! Você tá dentro."),
            action: SnackBarAction(
              label: "Ok",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ));
        },
        child: Text("Deu tudo certo! Você tá dentro."),
      );
    };
  }

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
            SizedBox(
              height: 20,
            ),
            EditorUsuario(
              controller: this._campoNomeController,
              dica: "João Silva",
              rotulo: "Nome Completo",
              icon: Icon(Icons.account_circle_outlined),
              tipoEntrada: TextInputType.name,
            ),
            EditorUsuario(
              controller: this._campoCpfController,
              rotulo: "CPF",
              icon: Icon(Icons.credit_card),
              tipoEntrada: TextInputType.number,
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
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
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 20),
                ),
              ),
              child: Text("Cadastrar"),
              onPressed: () {
                var nome = this._campoNomeController.text;
                var cpf = this._campoCpfController.text;
                var email = this._campoEmailController.text;
                var telefone = this._campoTelefoneController.text;

                Usuario usuario = Usuario(nome, cpf, email, telefone);

                if (validarDados(usuario.nome, usuario.cpf, usuario.email,
                    usuario.telefone)) {
                  print(usuario.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Deu tudo certo, você tá dentro!"),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: "Ok",
                        onPressed: () {},
                        textColor: Colors.white,
                      ),
                      duration: Duration(seconds: 6),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
