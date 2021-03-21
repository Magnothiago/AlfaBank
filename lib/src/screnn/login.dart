import 'package:alfa_banck/src/components/button_login_start.dart';
import 'package:alfa_banck/src/components/text_fild.dart';
import 'package:alfa_banck/src/screnn/screen_main.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
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
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 240,
              height: 240,
              //child: Image.asset('assets/Logo_alfa.png'),
              child: Image.asset('assets/alfa.png'),
              //child: Image.asset('assets/alfa_novo.png'),
            ),
            TextFildLogin(
              tipoTeclado: TextInputType.number,
              hintText: 'CPF',
              ocultarTexto: false,
              prefixIconData: Icons.mail_outline,
              controller: _controllerCpf,
              formatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
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
              aoClicar: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaPrincipal()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            // Button_login_inicial(
            //   title: 'Voltar',
            //   hasBorder: true,
            //   aoClicar: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
