import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/screnn/screen_inicial/home.dart';
import 'package:alfa_banck/src/screnn/tela_inicial.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  static const String routeName = 'root_page';
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Stream<Usuario> _currentUser;
  @override
  void initState() {
    _currentUser = repository.onAuthStateChange;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Usuario>(
        stream: _currentUser,
        builder: (BuildContext context, AsyncSnapshot<Usuario> snapshat) {
          return snapshat.hasData ? Perfil() : TelaInicial();
        }
    );
  }
}
