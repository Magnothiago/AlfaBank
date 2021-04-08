import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../screen_transfer.dart';
import '../screen_user_detail.dart';
import 'card_component.dart';
import 'stack_container.dart';

class Perfil extends StatelessWidget {
  static const String homeName = "tela_home";
  Stream<Usuario> _currentUser;
  @override
  Widget build(BuildContext context) {

    _currentUser = repository.onAuthStateChange;
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return StreamBuilder(
        stream: _currentUser,
        builder: (context, AsyncSnapshot<Usuario> snapshot) {
          return snapshot.hasData && snapshot.data.nome != null ?
          Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  StackContainer(),
                  CardItem('Saldo', Colors.black, '250.00', () {}),
                  SizedBox(
                    height: 10,
                  ),
                  CardItem(
                    'Nova transferência',
                    Colors.black,
                    '',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormularioTransferencia()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardItem(
                    'Fatura',
                    Colors.black,
                    '120',
                    () {
                      repository.signOut();
                      authenticationBloc.dispose();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardItem(
                    'Emprestimo',
                    Colors.black,
                    '9.000.00',
                    () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardItem(
                    'Editar Perfil',
                    Colors.black,
                    snapshot.data.nome,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PerfilUsuario()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ) : CircularProgressIndicator(backgroundColor: Colors.white,
            strokeWidth: 5,);
        });
  }
}
