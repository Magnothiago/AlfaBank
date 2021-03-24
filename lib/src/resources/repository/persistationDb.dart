import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersistenceService {
  //Usuario usuario;

  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

  Future<bool> adicionarUsuario(Usuario usuario) async {
    Usuario novoUsuario =  await findUsersByCpf(usuario.cpf).then((value) =>  value);
    try {
      if (novoUsuario != null) {
        print('retorno falso, pois já tem um usuário cadastrado');
        return false;
      }
      print("persistentio line: 17 ${usuario.toMap()}");
      await users
          .add(usuario.toMap())
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

  Future<List<Usuario>> findUsers() async {
    print('chamei a function');
    List<Usuario> usuarios = [];
    await users.get().then((QuerySnapshot query) {
      query.docs.forEach((usuario) {
        print('dentro do for');
        Usuario u = Usuario.unMap(usuario.data());
        usuarios.add(u);
        print(u);
      });
    });
    return usuarios;
  }

  Future<Usuario> findUsersByCpf(String cpf) async {
    print('entrei no find');
    Usuario usuario;
    try {
      usuario = await users.where('cpf', isEqualTo: cpf).get().then((result) {
        print("persistation line 55\n ${result.size}");
        if (result.size > 1) {
          return null;
        } else {
          return Usuario.unMap(result.docs.first.data());
        }
      });
      return usuario;
    } catch (e) {
      print("findUserByCPF line: 50\n ${e.toString()}");
    }
    return usuario;
  }
}

PersistenceService persistenceService = PersistenceService();
