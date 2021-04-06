import 'dart:async';

import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository/persistationDb.dart';
import 'package:alfa_banck/src/resources/repository/persistionSQFLITE.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationResources {
  //implementei firebase Auth para que nessa classe eu tenha acesso a todos os metodos do firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //Recebe no seu fluxo objetos do tipo do firebase user, contem todas as informações do usuario atual logado
  Stream<User> get onAuthStateChange => _firebaseAuth.authStateChanges();
  BehaviorSubject<Usuario> usuarioAutenticado = BehaviorSubject<Usuario>();

  //observable
  Observable<Usuario> get user => usuarioAutenticado.stream.transform
  (StreamTransformer<Usuario, Usuario>.fromHandlers(handleData: (user, sink) =>
  sink.add(user)));

  Function(Usuario) get changeUser => usuarioAutenticado.add;
  Future<int> cadastrarComEmailAndSenha(Usuario usuario) async {
    try {
      bool salvar = await persistenceService.adicionarUsuario(usuario);
      if (salvar) {
        await _firebaseAuth.createUserWithEmailAndPassword(email: usuario.email, password: usuario.senha);
        return 1;
      } else {
        print('Ocorreu algum problema ao cadastrar o usuário, criar mensagem para exibição.');
        return 0;
      }
    } on PlatformException catch (e) {
      print('authentication_resources line: 22\n Platform Exception: Authentication ${e.toString()}');
      return -1;
    } catch (e) {
      print('authentication_resources line: 22\n Authenticaton ${e.toString()}');
      return -2;
    }
  }
  Future<int> cadastrarComEmailAndSenhaSQL(Usuario usuario) async {
    try {
      PersistenceServiceSQL persistenceServiceSQL = PersistenceServiceSQL
          .instancia;
      bool salvar = await persistenceServiceSQL.insertUsuario(usuario);
      if (salvar) {
        return 1;
      } else {
        print('Ocorreu algum problema ao cadastrar o usuário, criar mensagem para exibição.');
        return 0;
      }
    } on PlatformException catch (e) {
      print('authentication_resources line: 22\n Platform Exception: Authentication ${e.toString()}');
      return -1;
    } catch (e) {
      print('authentication_resources line: 22\n Authenticaton ${e.toString()}');
      return -2;
    }
  }


  Future<int> loginComEmailAndSenha(Usuario usuario, String email, String
  senha) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
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

  Future<int> loginComCPFAndSenhaSQL(String cpf, String
  senha) async {
    try {
      PersistenceServiceSQL db = PersistenceServiceSQL.instancia;
      Usuario u = await db.findUsuarioByCPF(cpf);
      if(u != null && u.cpf == cpf && u.senha == senha ) {
        print("Ok: usuario: ${u.nome}");
        usuarioAutenticado.sink.add(u);
        return 1;
      } else return 0;
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

  Future<void> get sairSQL async {

  }


  Future<void> setUserDisplayName(String displayName) async {
    onAuthStateChange.listen((event) {
      print(event);
      event.updateProfile(displayName: displayName);
   });
  }

  void alterarUsuarioLogado(Usuario usuario) async {
    authenticationBloc.mudarEmail(usuario.email);
    authenticationBloc.mudarNomeUsuario(usuario.nome);
    authenticationBloc.mudarIsLogado(true);
    authenticationBloc.mudarCpf(usuario.cpf);
    await setUserDisplayName(usuario.nome);
  }
}
