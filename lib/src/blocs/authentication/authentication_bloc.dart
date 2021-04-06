import 'dart:async';
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class AuthenticationBloc implements Bloc {
  final _email = BehaviorSubject<String>();
  final _nomeUsuario = BehaviorSubject<String>();
  final _cpf = BehaviorSubject<String>();
  final _senha = BehaviorSubject<String>();
  final _telefone = BehaviorSubject<String>();
  final _isLogaddo = BehaviorSubject<bool>();
  final _usuario = BehaviorSubject<Usuario>();

  //observaveis
  Observable<String> get email =>
      _email.stream.transform(StreamTransformer<String, String>
          .fromHandlers(handleData: (email, sink) => sink.add(email)));

  Observable<String> get nomeUsuario => _nomeUsuario.stream.transform(
      StreamTransformer<String, String>
          .fromHandlers(handleData: (nomeUsuario, sink) => sink.add(nomeUsuario)));

  Observable<String> get cpfUsuario => _nomeUsuario.stream.transform(
      StreamTransformer<String, String>
          .fromHandlers(handleData: (cpfUsuario, sink) => sink.add(cpfUsuario)));

  Observable<String> get senha =>
      _senha.stream.transform(StreamTransformer<String, String>
          .fromHandlers(handleData: (senha, sink) => sink.add(senha)));

  Observable<String> get telefone => _telefone.stream.transform(
      StreamTransformer<String, String>
          .fromHandlers(handleData: (telefone, sink) => sink.add(telefone)));

  Observable<bool> get isLogado => _isLogaddo.stream;

  Observable<Usuario> get usuario => _usuario.stream.transform
    (StreamTransformer<Usuario, Usuario>.fromHandlers(handleData: (usuario,
      sink) => sink.add(usuario)));

  //mudar valores
  Function(String) get mudarEmail => _email.sink.add;
  Function(String) get mudarNomeUsuario => _nomeUsuario.sink.add;
  Function(String) get mudarCpf => _cpf.sink.add;
  Function(String) get mudarSenha => _senha.sink.add;
  Function(String) get mudarTelefone => _telefone.sink.add;
  Function(bool) get mudarIsLogado => _isLogaddo.sink.add;
  Function(Usuario) get mudarUsuario => _usuario.sink.add;

  @override
  void dispose() async {
    await _nomeUsuario.drain();
    _nomeUsuario.close();
    await _email.drain();
    _email.close();
    await _cpf.drain();
    _cpf.close();
    await _senha.drain();
    _senha.close();
    await _telefone.drain();
    _telefone.close();
    await _isLogaddo.drain();
    _isLogaddo.close();
    await _usuario.drain();
    _usuario.close();
  }
}

AuthenticationBloc authenticationBloc = AuthenticationBloc();
