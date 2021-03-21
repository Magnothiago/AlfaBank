
import 'package:alfa_banck/src/resources/authentication_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';

//classe que vai ter os metodos referente ao backend somente ela acessara os metodos dos blocks
class Repository {

  final _authResources = AuthenticationResources();

  Stream<User> get onAuthStateChange => _authResources.onAuthStateChange;
  Future<int> cadastroComEmailAndSenha(String email, String senha) => _authResources.cadastrarComEmailAndSenha(email, senha);
  Future<int> loginComEmailAndSenha(String email, String senha) => _authResources.loginComEmailAndSenha(email, senha);
  Future<void> signOut() => _authResources.sair;
}