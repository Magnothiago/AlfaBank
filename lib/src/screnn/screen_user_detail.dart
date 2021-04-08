import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/screnn/screen_inicial/card_component.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  static const String routeName = "tela_user_detalhes";
  Stream<Usuario> _currentUser;

  @override
  Widget build(BuildContext context) {
    _currentUser = repository.onAuthStateChange;
    return StreamBuilder(
      stream: _currentUser,
      builder: (context, AsyncSnapshot<Usuario> snapshot) {
        return snapshot.hasData
            ? Scaffold(

                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.redAccent,
                  centerTitle: true,
                  title: Text('Meu Pefil'),
                ),
                body: Card(

                  shadowColor: Colors.black,
                  elevation: 50,
                  margin: EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        SizedBox(height: 10),
                        CardItem("Nome", Colors.black, "${snapshot.data.nome}",
                            () {}),
                        SizedBox(height: 10),
                        CardItem("CPF", Colors.black, "${snapshot.data.cpf}",
                            () {}),
                        SizedBox(height: 10),
                        CardItem("E-mail", Colors.black,
                            "${snapshot.data.email}", (){}),
                        SizedBox(height: 10),
                        CardItem("Telefone", Colors.black,
                            "${snapshot.data.telefone}", () {}),
                      ],
                    ),
                ),
              )
            : Container();
      },
    );
  }
}
