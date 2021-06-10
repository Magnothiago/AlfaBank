import 'package:alfa_banck/src/card_model/operation_model.dart';
import 'package:alfa_banck/src/components/editorUsuario.dart';
import 'package:alfa_banck/src/modules/cartao.dart';
import 'package:alfa_banck/src/modules/transaction.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/Convert.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceCards.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceTransactions.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceUsers.dart';
import 'package:alfa_banck/src/screnn/cartao_screen/Home_cartao.dart';
import 'package:alfa_banck/src/screnn/screen_inicial/home.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CompraCartao extends StatefulWidget {
  static String routeName = "home_cartao";

  @override
  _ComprarCartaoState createState() => _ComprarCartaoState();
}

class _ComprarCartaoState extends State<CompraCartao> {
  final TextEditingController _campoNomeProduto = TextEditingController();
  final TextEditingController _campoValor = TextEditingController();

  Usuario user;
  Stream<User> _currentUser = repository.onAuthStateChange;
  Stream<Cartao> card;
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
    _initUserAndCard();

    super.initState();
  }

  void _initUserAndCard() async {
    String email;

    _currentUser.listen((event) {
      email = event.email;
    });
    this.user = await persistenceServiceUsers.findUsersByEmail(email);
    card = persistenceServiceCards.findCardByCpf(user.cpf).asStream();

    super.setState(() {
      user = user;
      card = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';Intl.defaultLocale = 'pt_BR';
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
                height: 20,
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
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16, right: 6),
                  // itemCount: cards.length,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return StreamBuilder<Cartao>(
                        stream: card,
                        builder: (BuildContext context,
                            AsyncSnapshot<Cartao> snapshot) {
                          return snapshot.hasData
                              ? cardComponent(index, snapshot.data)
                              : Center(child: CircularProgressIndicator());
                        });
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
                      "Comprar",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      EditorUsuario(
                        controller: this._campoNomeProduto,
                        rotulo: "Produto",
                        icon: Icon(Icons.add_box),
                        tipoEntrada: TextInputType.text,
                        formatters: [],
                      ),
                      EditorUsuario(
                        controller: this._campoValor,
                        rotulo: "Valor",
                        icon: Icon(Icons.credit_card),
                        tipoEntrada: TextInputType.number,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(moeda: true, centavos: true)
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          style: ButtonStyle(
                            alignment: Alignment.bottomLeft,
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20),
                            ),
                          ),
                          child: Text("Comprar"),
                          onPressed: () async {
                            var produto = this._campoNomeProduto.text;
                            var valor = this._campoValor.text;

                            bool retorno = await lancarCompra(produto, valor);
                            if (retorno) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Compra realizada com sucesso."),
                                  backgroundColor: Colors.red,
                                  action: SnackBarAction(
                                    label: "Ok",
                                    onPressed: () {},
                                    textColor: Colors.white,
                                  ),
                                  duration: Duration(seconds: 6),
                                ),
                              );
                              this._campoNomeProduto.clear();
                              this._campoValor.clear();
                              setState(() {
                                _initUserAndCard();
                              });
                            } else {
                              //TODO EXTRAIR SCAFFOLDMESENGER E CONFIGURAR EM UM METODO
                              // A PARTE
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Falha ao realizar a compra, verifique o limite disponível!"),
                                  backgroundColor: Colors.red,
                                  action: SnackBarAction(
                                    label: "Ok",
                                    onPressed: () {},
                                    textColor: Colors.white,
                                  ),
                                  duration: Duration(seconds: 8),
                                ),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> lancarCompra(String produto, String valor) async {
    bool retorno;
    TransactionUsers transaction = TransactionUsers(produto, "assets/images/carr.png", Timestamp.now(), valor, user);
    Cartao card = await persistenceServiceCards.findCardByCpf(user.cpf);
    double limiteTotal = Convert.convertDouble(card.cardLimit);
    double limiteAtual = Convert.convertDouble(card.limiteAtual);
    double valorCompra = Convert.convertDouble(valor);
    double faturaAtual = Convert.convertDouble(card.totalGasto);

    if(limiteAtual < valorCompra) {
      return false;
    }

    limiteAtual = limiteAtual - valorCompra;
    faturaAtual = limiteTotal - limiteAtual;

    card.limiteAtual = Convert.convertDoubleReal(limiteAtual);
    card.totalGasto = Convert.convertDoubleReal(faturaAtual);
    persistenceServiceCards.atualizarLimite(card);
    retorno = await persistenceServiceTransactions.adicionarTransacao(transaction);
    return retorno;
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
            child: SvgPicture.asset(card.cardElementTop),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(card.cardElementBottom),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            left: 250,
            bottom: 30,
            child: Text(
              "Limite",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            left: 250,
            bottom: 10,
            child: Text(
              card.limiteAtual,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _ComprarCartaoState context;

  OperationCard(
      {this.operation,
      this.selectedIcon,
      this.unselectedIcon,
      this.isSelected,
      this.context});

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
          TextButton(
            child: Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected ? Colors.white : Colors.blue),
            ),
            onPressed: () {
              if(widget.operation == "Extrato") {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeCartao()));
              }
            },
          )
        ],
      ),
    );
  }
}
