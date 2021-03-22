
import 'package:alfa_banck/src/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  final bloc = AuthenticationBloc();

  AuthenticationBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AuthenticationBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AuthenticationBlocProvider>()).bloc;
  }
}