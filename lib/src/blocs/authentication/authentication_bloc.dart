import 'dart:async';

import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class AuthenticationBloc implements Bloc {
  final _email = BehaviorSubject<String>();
  final _nomeUsuario = BehaviorSubject<String>();
  final _senha = BehaviorSubject<String>();
  final _isLogaddo = BehaviorSubject<bool>();

  //observaveis
  Observable<String> get email =>
      _email.stream.transform(streamTransformer(email));

  Observable<String> get nomeUsuario =>
      _nomeUsuario.stream.transform(streamTransformer(nomeUsuario));

  Observable<String> get senha =>
      _senha.stream.transform(streamTransformer(senha));

  Observable<bool> get isLogado => _isLogaddo.stream;

  StreamTransformer<String, String> streamTransformer(valor) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (valor, sink) => sink.add(valor));


  //mudar valores
  Function(String) get mudarEmail => _email.sink.add;
  Function(String) get mudarNomeUsuario => _nomeUsuario.sink.add;
  Function(String) get mudarSenha => _senha.sink.add;
  Function(bool) get mostrarProgressBar => _isLogaddo.sink.add;

  Future<int> loginUsuario() async {
    mostrarProgressBar(true);
    int response = await repository.loginComEmailAndSenha(_email.value, _senha.value);
    isLogado.listen((event) {
      print("authentication_bloc line: 42\n, login: $event");
    });
    mostrarProgressBar(false);
    return response;
  }


  Future<int> registrarUsuario(Usuario usuario) async {
    mostrarProgressBar(true);
    int response = await repository.cadastroComEmailAndSenha(usuario);
    mostrarProgressBar(false);
    return response;
  }

  @override
  void dispose() async {
    await _nomeUsuario.drain();
    _nomeUsuario.close();

    await _email.drain();
    _email.close();

    await _senha.drain();
    _senha.close();

    await _isLogaddo.drain();
    _isLogaddo.close();
  }
}
