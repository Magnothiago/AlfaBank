import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../screen_user_detail.dart';
import 'card_component.dart';
import 'stack_container.dart';

class Perfil extends StatelessWidget {
  static const String homeName = "tela_home";
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackContainer(),
            CardItem(
              'Saldo',
              Colors.black,
              '250.00',
              () {}
            ),
            SizedBox(
              height: 10,
            ),
            CardItem(
              'Nova transferência',
              Colors.black,
              '',
              () {
              },
            ),
            SizedBox(
              height: 10,
            ),
            CardItem(
              'Fatrura',
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
              'Nome do cara',
                  () {
               Navigator.push(context,
                 MaterialPageRoute(builder: (context)=> PerfilUsuario() ), );
                  },
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
