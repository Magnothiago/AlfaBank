import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  static const String routeName = "tela_user_detalhes";
  Stream<Usuario> _currentUser;

  @override
  Widget build(BuildContext context) {
    _currentUser = authenticationBloc.usuario;
    return StreamBuilder(
      stream: _currentUser,
      builder: (context, AsyncSnapshot<Usuario> snapshot) {
        print(snapshot.data.toString());
        return snapshot.hasData ? Scaffold(
          backgroundColor: Colors.redAccent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.redAccent,
            centerTitle: true,
            title: Text('Meu Pefil'),
          ),
          body: Card(
            semanticContainer: true,
            color: Colors.redAccent,
            child: Align(
                  alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Nome: ${snapshot.data.nome}",
                            style: TextStyle(color: Colors.white, fontSize: 20, ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'CPF: ${snapshot.data.cpf}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'E-mail: ${snapshot.data.email}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Telefone: ${snapshot.data.telefone}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),

                        ],
                      ),
                    ),
                  ),
        ) : Container();
      },
    );
  }
}
