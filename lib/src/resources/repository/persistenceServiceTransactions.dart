import 'package:alfa_banck/src/modules/transaction.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceServiceTransactions {

  CollectionReference transactions = FirebaseFirestore.instance.collection('transacoes');

  Future<bool> adicionarTransacao(TransactionUsers transaction) async {
    Usuario novoUsuario = await persistenceServiceUsers.findUsersByCpf(transaction.user.cpf).then((
        value) => value);
    try {
      if (novoUsuario == null) {
        //retorno falso, pois já tem um usuário cadastrado
        return false;
      }
      print("persistentio line: 17 ${transaction.toMap()}");
      await transactions
          .add(transaction.toMap())
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

  Future<List<TransactionUsers>> findTransactionsCurrentUser() async {
    List<TransactionUsers> transactionsUsers = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Usuario usuario = await persistenceServiceUsers.findUsersByCpf(prefs.getString("cpf"));

    await transactions.get().then((QuerySnapshot query) {
      query.docs.forEach((transaction) {
        TransactionUsers u = unMap(transaction.data(), usuario);
        transactionsUsers.add(u);
        print("email usuario atual: " + "" + prefs.getString("uid"));
        print(u);
      });
    });
    return transactionsUsers;
  }

//reflexão, getx, provider
  TransactionUsers unMap(Map<String, dynamic> transaction, Usuario user) {
    return TransactionUsers(transaction['name'], transaction['photo'], transaction['date'], transaction['value'], user);
  }

}
PersistenceServiceTransactions persistenceServiceTransactions = PersistenceServiceTransactions();
