import 'dart:async';

import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository/persistionSQFLITE.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationResources {
  BehaviorSubject<Usuario> usuarioAutenticado = BehaviorSubject<Usuario>();

  //observable
  Observable<Usuario> get user => usuarioAutenticado.stream.transform(
      StreamTransformer<Usuario, Usuario>.fromHandlers(
          handleData: (user, sink) => sink.add(user)));

  Function(Usuario) get changeUser => usuarioAutenticado.add;

  Future<int> cadastrarComEmailAndSenhaSQL(Usuario usuario) async {
    try {
      PersistenceServiceSQL persistenceServiceSQL = PersistenceServiceSQL.instancia;
      bool salvar = await persistenceServiceSQL.insertUsuario(usuario);
      if (salvar) {
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

  Future<int> loginComCPFAndSenhaSQL(String cpf, String senha) async {
    try {
      PersistenceServiceSQL db = PersistenceServiceSQL.instancia;
      Usuario u = await db.findUsuarioByCPF(cpf);
      if (u != null && u.cpf == cpf && u.senha == senha) {
        usuarioAutenticado.sink.add(u);
        return 1;
      } else
        return 0;
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

  Future<void> get sairSQL async {}

  void alterarUsuarioLogado(Usuario usuario) async {
    authenticationBloc.mudarEmail(usuario.email);
    authenticationBloc.mudarNomeUsuario(usuario.nome);
    authenticationBloc.mudarCpf(usuario.cpf);
    authenticationBloc.mudarTelefone(usuario.telefone);
    authenticationBloc.mudarSenha(usuario.senha);
    authenticationBloc.mudarUsuario(usuario);
  }
}
