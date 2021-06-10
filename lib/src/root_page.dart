import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceUsers.dart';
import 'package:alfa_banck/src/screnn/screen_inicial/home.dart';
import 'package:alfa_banck/src/screnn/tela_inicial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatefulWidget {
  static const String routeName = 'root_page';
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Stream<User> _currentUser;

  @override
  void initState() {
    _currentUser = repository.onAuthStateChange;
    super.initState();
  }

  void criarPreferences(User u) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Usuario usuarioLogado = await persistenceServiceUsers.findUsersByEmail(
        u.email);

    prefs.setString("cpf", usuarioLogado.cpf);
    prefs.setString("email", usuarioLogado.email);
    prefs.setString("telefone", usuarioLogado.telefone);
    prefs.setString("nome", usuarioLogado.nome);
    prefs.setString("uid", u.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: _currentUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshat) {
          if (snapshat.hasData) {
            criarPreferences(snapshat.data);
            return Perfil();
          }
          return TelaInicial();
        }
    );
  }

}
