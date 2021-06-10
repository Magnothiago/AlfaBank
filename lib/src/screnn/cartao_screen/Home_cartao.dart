import 'package:alfa_banck/src/card_model/operation_model.dart';
import 'package:alfa_banck/src/modules/cartao.dart';
import 'package:alfa_banck/src/modules/transaction.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceCards.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceTransactions.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceUsers.dart';
import 'package:alfa_banck/src/screnn/screen_inicial/home.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeCartao extends StatefulWidget {
  static String routeName = "home_cartao";

  @override
  _HomeCartaoState createState() => _HomeCartaoState();
}

class _HomeCartaoState extends State<HomeCartao> {
  Usuario user;
  List<TransactionUsers> transacoes = [];
  Stream<User> _currentUser = repository.onAuthStateChange;
  Stream<Cartao> card;
  Stream<List<TransactionUsers>> _transactions;
  int current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  void initState() {
    user = new Usuario("", "", "", "", "");
    _initTransations();
    _initUserAndCard();

    super.initState();
  }

  void _initUserAndCard() async {
    String email;
    _currentUser.listen((event) { email = event.email; });
    this.user = await persistenceServiceUsers.findUsersByEmail(email);
    card = persistenceServiceCards.findCardByCpf(user.cpf).asStream();
    super.setState(() {
      user = user;
      card = card;
    });
  }

  void _initTransations() async {
    _transactions = persistenceServiceTransactions.findTransactionsCurrentUser().asStream();
    transacoes = await persistenceServiceTransactions.findTransactionsCurrentUser();
    setState(() {
      transacoes = transacoes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              //Custom appbar
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Perfil.homeName);
                      },
                      child: SvgPicture.asset('assets/svg/drawer_icon.svg'),
                    ),
                    Container(
                      height: 59,
                      width: 59,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image:
                              AssetImage('assets/images/user_image.png'))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Boa tarde!",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      user.nome,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16, right: 6),
                  // itemCount: cards.length,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return StreamBuilder<Cartao> (
                      stream: card,
                      builder: (BuildContext context, AsyncSnapshot<Cartao> snapshot) {
                        return snapshot.hasData ? cardComponent(index, snapshot.data) : Center(child: CircularProgressIndicator());
                      }
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 13, top: 29, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Operações",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: map<Widget>(
                        datas,
                            (index, select) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            height: 9,
                            width: 9,
                            margin: EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: current == index
                                    ? Colors.pinkAccent
                                    : Colors.black26),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 123,
                child: ListView.builder(
                  itemCount: datas.length,
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });

                      },
                      child: OperationCard(
                          operation: datas[index].name,
                          selectedIcon: datas[index].selectedIcon,
                          unselectedIcon: datas[index].unselectedIcon,
                          isSelected: current == index,
                          context: this),
                    );
                  },
                ),
              ),
              //operation section
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 13, top: 29, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Histórico",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<TransactionUsers>>(
                stream: _transactions,
                builder: (BuildContext context, AsyncSnapshot<List<TransactionUsers>> asyncSnapshot) {
                    return asyncSnapshot.hasData ?
                    ListView.builder(
                      itemCount: transacoes.length,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 76,
                          margin: EdgeInsets.only(bottom: 13),
                          padding: EdgeInsets.only(
                              left: 24, top: 12, bottom: 12, right: 22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  offset: Offset(8.0, 8.0))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 57,
                                    width: 57,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(transacoes[index].photo),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(transacoes[index].name),
                                      Text(UtilData.obterDataDDMMAAAA(transacoes[index].date.toDate()))
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    transacoes[index].value,
                                    style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                        : Center(child: CircularProgressIndicator(backgroundColor: Colors.red,));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container cardComponent(int index, Cartao card) {
    return Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 199,
                    width: 376,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(card.cardBackground),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          child:
                          SvgPicture.asset(card.cardElementTop),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(
                              card.cardElementBottom),
                        ),
                        Positioned(
                          left: 29,
                          top: 48,
                          child: Text(
                            'CARD NUMBER',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          top: 48,
                          child: Text(
                            'CARD NUMBER',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          top: 65,
                          child: Text(
                            card.cardNumber,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          right: 21,
                          top: 15,
                          child: Image.asset(card.cardType),
                          width: 40,
                          height: 40,
                        ),
                        Positioned(
                          left: 29,
                          bottom: 80,
                          child: Text(
                            "Cliente",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 60,
                          child: Text(
                            card.user.nome,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 30,
                          child: Text(
                            "Limite Total",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 10,
                          child: Text(
                            card.cardLimit,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Positioned(
                          left: 250,
                          bottom: 80,
                          child: Text(
                            "Validade",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 250,
                          bottom: 60,
                          child: Text(
                            card.cardExpired,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Positioned(
                          left: 250,
                          bottom: 30,
                          child: Text(
                            "Limite Disponível",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 250,
                          bottom: 10,
                          child: Text(
                            card.limiteAtual,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  );
  }
}

// ignore: must_be_immutable
class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _HomeCartaoState context;

  OperationCard(
      {
        this.operation,
        this.selectedIcon,
        this.unselectedIcon,
        this.isSelected,
        this.context
      });

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 123,
      width: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white30,
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(8.0, 8.0))
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? Colors.blue : Colors.white30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected ? Colors.white : Colors.blue),
          )
        ],
      ),
    );
  }
}

