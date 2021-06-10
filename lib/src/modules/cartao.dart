import 'package:alfa_banck/src/modules/usuario.dart';

class Cartao {
  Usuario user;
  String cardNumber;
  String cardExpired;
  String cardType;
  int cardBackground;
  String cardElementTop;
  String cardElementBottom;
  String cardLimit;
  String totalGasto;
  String limiteAtual;

  Cartao(this.user, this.cardNumber, this.cardExpired, this.cardType,
      this.cardBackground, this.cardElementTop, this.cardElementBottom, this.cardLimit, this.totalGasto, this.limiteAtual);

  @override
  String toString() {
    return "Transations(cardNumber: $cardNumber, cardExpired: $cardExpired, cardLimit: $cardLimit)";
  }

  Map<String, dynamic> toMap() {
    return {
    'user': user.cpf,
    'cardNumber': cardNumber,
    'cardExpired': cardExpired,
    'cardType': cardType,
    'cardBackground': cardBackground,
    'cardElementTop': cardElementTop,
    'cardElementBottom': cardElementBottom,
    'cardLimit': cardLimit,
    'totalGasto': totalGasto,
    'limiteAtual': limiteAtual
    };
  }
}