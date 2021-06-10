import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersistenceServiceUsers {

  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

  Future<bool> adicionarUsuario(Usuario usuario) async {
    Usuario novoUsuario = await findUsersByCpf(usuario.cpf).then((
        value) => value);
    try {
      if (novoUsuario != null) {
        //retorno falso, pois já tem um usuário cadastrado
        return false;
      }
      await users
          .add(usuario.toMap())
          .then((a) => print('persistion line: 22\nSalvei o usuario'))
          .catchError(
            (error) {
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
    List<Usuario> usuarios = [];
    await users.get().then((QuerySnapshot query) {
      query.docs.forEach((usuario) {
        Usuario u = unMap(usuario.data());
        usuarios.add(u);
        print(u);
      });
    });
    return usuarios;
  }

  Future<Usuario> findUsersByCpf(String cpf) async {
    Usuario usuario;
    try {
        usuario = await users.where('cpf', isEqualTo: cpf).get().then((result) {
        print("persistation line 55, size: ${result.size}");
        return (result.size > 1) ? null : unMap(result.docs.first.data());
      });
    return usuario;
    } catch (e) {
    print("findUserByCPF line: 50\n ${e.toString()}");
    return usuario;
    }
  }

  Future<Usuario> findUsersByEmail(String email) async {
    Usuario usuario;
    try {
      usuario = await users.where('email', isEqualTo: email).get().then((result) {
        print("persistation line 55, size: ${result.size}");
        return (result.size > 1) ? null : unMap(result.docs.first.data());
      });
      return usuario;
    } catch (e) {
      print("findUserByCPF line: 50\n ${e.toString()}");
      return usuario;
    }
  }

//reflexão, getx, provider
  Usuario unMap(Map<String, dynamic> usuario) {
    return Usuario(usuario['nome'], usuario['cpf'], usuario['email'], usuario['telefone'], usuario['senha']);
  }

}
PersistenceServiceUsers persistenceServiceUsers = PersistenceServiceUsers();
