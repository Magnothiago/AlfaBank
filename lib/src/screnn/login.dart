import 'package:alfa_banck/src/components/button_login_start.dart';
import 'package:alfa_banck/src/components/text_fild.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistionSQFLITE.dart';
import 'package:alfa_banck/src/root_page.dart';
import 'package:alfa_banck/src/screnn/tela_inicial.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
  final persistenceServiceSQL = PersistenceServiceSQL.instancia;
  static const String routeName = "login_page";
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            SizedBox(
              width: 240,
              height: 240,
              child: Image.asset('assets/alfa.png'),
            ),
            TextFildLogin(
              tipoTeclado: TextInputType.number,
              hintText: 'CPF',
              ocultarTexto: false,
              prefixIconData: Icons.mail_outline,
              controller: _controllerCpf,
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFildLogin(
                  tipoTeclado: TextInputType.number,
                  hintText: 'Senha',
                  ocultarTexto: true,
                  prefixIconData: Icons.lock_outline,
                  controller: _controllerPassword,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Button_login_inicial(
              title: 'Login',
              hasBorder: true,
              aoClicar: () async {
                bool isLogado = await autenticar(
                    _controllerCpf.value.text, _controllerPassword.value.text);
                chamarRota(isLogado, context);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Button_login_inicial(
              title: 'Voltar',
              hasBorder: true,
              aoClicar: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaInicial(),));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> autenticar(String cpf, String password) async {
    int retorno;
    Usuario u = await persistenceServiceSQL.findUsuarioByCPF(cpf);
    await repository.loginComCpfAndSenha(u, cpf, password)
        .then((value) => retorno = value);
    return usuarioAutenticado(retorno);
  }

  bool usuarioAutenticado(int i) {
    return i > 0 ? true : false;
  }

  chamarRota(bool b, BuildContext context) {
    if (b == true)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RootPage()));
  }
}
