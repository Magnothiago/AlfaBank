
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/authentication_resources.dart';

//classe que vai ter os metodos referente ao backend somente ela acessara os metodos dos blocks
class Repository {

  final _authResources = AuthenticationResources();

  Stream<Usuario> get onAuthStateChange => _authResources.user;
  Future<int> cadastroComEmailAndSenha(Usuario usuario) => _authResources
      .cadastrarComEmailAndSenhaSQL(usuario);
  Future<int> loginComCpfAndSenha(Usuario usuario, String cpf, String senha) =>
      _authResources.loginComCPFAndSenhaSQL(cpf, senha);
  Future<void> signOut() => _authResources.sairSQL;
}
Repository repository = Repository();