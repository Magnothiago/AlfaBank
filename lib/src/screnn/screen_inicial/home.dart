import 'package:alfa_banck/src/components/JanelaComprar.dart';
import 'package:alfa_banck/src/modules/cartao.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceCards.dart';
import 'package:alfa_banck/src/screnn/cartao_screen/Home_cartao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen_transfer.dart';
import '../screen_user_detail.dart';
import 'card_component.dart';
import 'stack_container.dart';

class Perfil extends StatelessWidget {
  static const String homeName = "tela_home";
  Stream<User> _currentUser;
  Stream<Cartao> cartao;
  String nome;
  String cpf;
  @override
  Widget build(BuildContext context) {

    void carregarPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cpf = prefs.getString('cpf');
      nome = prefs.getString('nome');

    }

    _currentUser = repository.onAuthStateChange;
    cartao = persistenceServiceCards.findCardByCpf(cpf).asStream();
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return StreamBuilder(
        stream: _currentUser,
        builder: (context, AsyncSnapshot<User> snapshot) {
          return snapshot.hasData && snapshot.data.displayName != null ?
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
                  StreamBuilder<Cartao>(
                    stream: cartao,
                    builder: (BuildContext context, AsyncSnapshot<Cartao> snap) {
                      return snap.hasData ? CardItem(
                        'Fatura',
                        Colors.black,
                        '${snap.data.totalGasto == null ? 0.0 : snap.data.totalGasto}',
                            () async {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HomeCartao()));
                        },
                      ) : Center(child: CircularProgressIndicator(backgroundColor: Colors.red));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardItem(
                    'Comprar',
                    Colors.black,
                    "Comprar no Cartão de Crédito",
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CompraCartao()));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardItem(
                    'Editar Perfil',
                    Colors.black,
                    snapshot.data.displayName,
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
          ) : Center(child: CircularProgressIndicator(backgroundColor: Colors.red,
            strokeWidth: 5,));
        });
  }
}
