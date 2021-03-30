import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class AuthenticationBloc implements Bloc {
  final _email = BehaviorSubject<String>();
  final _nomeUsuario = BehaviorSubject<String>();
  final _cpf = BehaviorSubject<String>();
  final _senha = BehaviorSubject<String>();
  final _isLogaddo = BehaviorSubject<bool>();

  //observaveis
  Observable<String> get email =>
      _email.stream.transform(StreamTransformer<String, String>.fromHandlers
        (handleData: (email, sink) => sink.add(email)));

  Observable<String> get nomeUsuario => _nomeUsuario.stream.transform(
      StreamTransformer<String, String>.fromHandlers(
          handleData: (nomeUsuario, sink) => sink.add(nomeUsuario)));

  Observable<String> get cpfUsuario => _nomeUsuario.stream.transform(
      StreamTransformer<String, String>.fromHandlers(
          handleData: (cpfUsuario, sink) => sink.add(cpfUsuario)));

  Observable<String> get senha =>
      _senha.stream.transform(StreamTransformer<String, String>.fromHandlers(
          handleData: (senha, sink) => sink.add(senha)));

  Observable<bool> get isLogado => _isLogaddo.stream;

  //mudar valores
  Function(String) get mudarEmail => _email.sink.add;

  Function(String) get mudarNomeUsuario => _nomeUsuario.sink.add;

  Function(String) get mudarCpf => _cpf.sink.add;

  Function(String) get mudarSenha => _senha.sink.add;

  Function(bool) get mudarIsLogado => _isLogaddo.sink.add;

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

    await _isLogaddo.drain();
    _isLogaddo.close();
  }
}

AuthenticationBloc authenticationBloc = AuthenticationBloc();
