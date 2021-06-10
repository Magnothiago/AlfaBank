import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/modules/cartao.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersistenceServiceCards {

  CollectionReference cards = FirebaseFirestore.instance.collection('cartoes');

  Future<bool> adicionarCard(Cartao card) async {
    Usuario usuario = await persistenceServiceUsers.findUsersByCpf(card.user.cpf).then((
        value) => value);
    try {
      if (usuario == null) {
        return false;
      }
      print("persistentio line: 17 ${usuario.toMap()}");
      await cards.doc('cartoes').collection(usuario.cpf).doc(usuario.email).set(card.toMap())
          .then((a) => print('persistion line: 22\nSalvei o usuario'))
          .catchError(
            (error) {
          print('persistion line: 24\nError: $error');
          return false;
        },
      );
      return true;
    } catch (e) {
      print('persision line 26: ${e.toString()}');
      return false;
    }
  }

  Future<bool> atualizarLimite(Cartao cartao) async {
    await cards.doc('cartoes').collection(cartao.user.cpf).doc(cartao.user.email).update(cartao.toMap());
    return false;
  }

  Future<List<Cartao>> findCards() async {
    List<Cartao> cartoes = [];
    Usuario usuario = await persistenceServiceUsers.findUsersByEmail(authenticationBloc.email.toString());
    await cards.doc('cartoes').collection(usuario.cpf).doc(usuario.email).get().then((result) => {
      unMap(result.data(), usuario)
    });
    return cartoes;
  }

  Future<Cartao> findCardByCpf(String cpf) async {
    Usuario usuario;
    Cartao card;
    try {
        usuario = await persistenceServiceUsers.findUsersByCpf(cpf);

        if (usuario == null) {
          throw new Error();
        }
        card = await cards.doc('cartoes').collection(usuario.cpf).doc(usuario.email).get().then((result) {
          return unMap(result.data(), usuario);
      });
    return card;
    } catch (e) {
    return card;
    }
  }
//reflexão, getx, provider
  Cartao unMap(Map<String, dynamic> card, Usuario  usuario) {
    return Cartao(usuario, card['cardNumber'], card['cardExpired'], card['cardType'], card['cardBackground'],
        card['cardElementTop'], card['cardElementBottom'], card['cardLimit'], card['totalGasto'], card['limiteAtual']);
  }

}
PersistenceServiceCards persistenceServiceCards = PersistenceServiceCards();
