import 'package:alfa_banck/src/root_page.dart';
import 'package:alfa_banck/src/screnn/screen_inicial/home.dart';
import 'package:alfa_banck/src/screnn/screen_transfer.dart';
import 'package:alfa_banck/src/screnn/screen_user_detail.dart';
import 'package:alfa_banck/src/screnn/screen_user_form.dart';
import 'package:alfa_banck/src/screnn/login.dart';
import 'package:alfa_banck/src/screnn/tela_inicial.dart';
import 'package:alfa_banck/src/screnn/screen_main.dart';
import 'package:flutter/material.dart';

class AlfaBank extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.redAccent,
          ),
        ),
        initialRoute: RootPage.routeName,
        routes: {
          RootPage.routeName: (context) => RootPage(),
          Login.routeName: (context) => Login(),
          TelaPrincipal.routeName: (context) => TelaPrincipal(),
          TelaInicial.routeName: (context) => TelaInicial(),
          CadastroUsuario.routeName: (context) => CadastroUsuario(),
          Perfil.homeName:(context)=> Perfil(),
          PerfilUsuario.routeName:(context)=> PerfilUsuario(),
          FormularioTransferencia.routName:(context)=> FormularioTransferencia()
        }
    );
  }
}