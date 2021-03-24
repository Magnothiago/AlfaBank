import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository/persistationDb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationResources {
  //implementei firebase Auth para que nessa classe eu tenha acesso a todos os metodos do firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Recebe no seu fluxo objetos do tipo do firebase user, contem todas as informações do usuario atual logado
  Stream<User> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Future<int> cadastrarComEmailAndSenha(Usuario usuario) async {
    try {
      print(
          "authentication_resources line: 16 ${usuario.email}, ${usuario.cpf}");
      bool salvar = await persistenceService.adicionarUsuario(usuario);
      if (salvar) {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha);
        return 1;
      } else {
        print(
            'Ocorreu algum problema ao cadastrar o usuário, criar mensagem para exibição.');
        return 0;
      }
    } on PlatformException catch (e) {
      print(
          'authentication_resources line: 22\n Platform Exception: Authentication ${e.toString()}');
      return -1;
    } catch (e) {
      print(
          'authentication_resources line: 22\n Authenticaton ${e.toString()}');
      return -2;
    }
  }

  Future<int> loginComEmailAndSenha(String email, String senha) async {
    try {
      print(
          'authentication_resources line: 32\ntentando: $email, senha: $senha');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return 1;
    } on PlatformException catch (e) {
      print(
          'authentication_resources line: 36\nPlatform exception: AuthenticationResources ${e.toString()}');
      return -1;
    } catch (e) {
      print(
          'authentication_resources  line: 36\nException: AuthenticationResources ${e.toString()}');
      return -2;
    }
  }

  Future<void> get sair async {
    _firebaseAuth.signOut();
  }

//TODO ESCREVER METODO LINHA 40 authentication_resources.dart

}
