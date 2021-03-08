import 'package:alfa_banck/screnn/formulario_cadastro_user.dart';
import 'package:flutter/material.dart';
import '../components/button_login.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 80,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              width: 240,
              height: 240,
              //child: Image.asset('assets/Logo_alfa.png'),
              child: Image.asset('assets/alfa.png'),
              //child: Image.asset('assets/alfa_novo.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Button(Colors.red, Colors.white, 'LOGIN', () {}),
            SizedBox(
              width: 30,
            ),
            Button(Colors.red, Colors.white, 'CRIAR CONTA', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroUsuario()),
              );
            }),
          ],
        ),
      ),
    );
  }
}
