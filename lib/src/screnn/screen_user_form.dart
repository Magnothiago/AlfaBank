import 'package:alfa_banck/src/components/editorUsuario.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistionSQFLITE.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroUsuario extends StatefulWidget {
  static const String routeName = 'cadastro_usuario';
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final _persistenceServiceSQL = PersistenceServiceSQL.instancia;
  final TextEditingController _campoNomeController = TextEditingController();
  final TextEditingController _campoCpfController = TextEditingController();
  final TextEditingController _campoEmailController = TextEditingController();
  final TextEditingController _campoTelefoneController =
      TextEditingController();
  final TextEditingController _campoSenhaController = TextEditingController();

  bool validarDados(nome, cpf, email, telefone) {
    return (nome != null &&
            CPF.isValid(cpf) &&
            email != null &&
            telefone != null)
        ? true
        : false;
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
                  controller: _campoEmailController,
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
            EditorUsuario(
              controller: this._campoSenhaController,
              dica: "",
              rotulo: "Senha",
              icon: Icon(Icons.lock),
              tipoEntrada: TextInputType.phone,
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              obscureText: true,
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
              onPressed: () async {
                await _persistenceServiceSQL.printAllUser();
                var nome = this._campoNomeController.text;
                var cpf = this._campoCpfController.text;
                var email = this._campoEmailController.text;
                var telefone = this._campoTelefoneController.text;
                var senha = this._campoSenhaController.text;

                Usuario usuario = Usuario(nome, cpf, email, telefone, senha);
                if (validarDados(usuario.nome, usuario.cpf, usuario.email, usuario.telefone)) {
                 int retorno = await repository.cadastroComEmailAndSenha(usuario);
                  if (retorno > 0) {
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
                    Navigator.pop(context, usuario);
                  } else {
                    //TODO EXTRAIR SCAFFOLDMESENGER E CONFIGURAR EM UM METODO
                    // A PARTE
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Deu ruim! Usuário já cadastrado."),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: "Ok",
                          onPressed: () {},
                          textColor: Colors.white,
                        ),
                        duration: Duration(seconds: 8),
                      ),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
