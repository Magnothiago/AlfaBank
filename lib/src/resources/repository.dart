
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/authentication_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';

//classe que vai ter os metodos referente ao backend somente ela acessara os metodos dos blocks
class Repository {

  final _authResources = AuthenticationResources();

  Stream<User> get onAuthStateChange => _authResources.onAuthStateChange;
  Future<int> cadastroComEmailAndSenha(Usuario usuario) => _authResources.cadastrarComEmailAndSenha(usuario);
  Future<int> loginComEmailAndSenha(String email, String senha) => _authResources.loginComEmailAndSenha(email, senha);
  Future<void> signOut() => _authResources.sair;

}
Repository repository = Repository();