import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersistenceService {
  //Usuario usuario;

  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

  Future<void> adicionarUsuario(Usuario usuario) async {
    return users
        .add(usuario.toMap())
        .then((a) => print('Salvei o usuario'))
        .catchError((error) => print('Error: $error'));
  }
}

PersistenceService persistenceService = PersistenceService();