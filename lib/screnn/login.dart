import 'package:alfa_banck/components/button_login_inicial.dart';
import 'package:alfa_banck/components/text_fild.dart';
import 'package:flutter/material.dart';


class Login extends StatelessWidget {
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
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
