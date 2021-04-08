import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:flutter/material.dart';
import 'custom_cliper.dart';
import 'top_bar.dart';


class StackContainer extends StatelessWidget {
  Stream<Usuario> _currentUser;
  @override
  Widget build(BuildContext context) {
   _currentUser = repository.onAuthStateChange;
    return StreamBuilder(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
        return snapshot.hasData ? Container(
          height: 300,
          child: Stack(
            children: [
              Container(),
              ClipPath(
                clipper: Mycustom(),
                child: Container(
                  height: 250,
                  color: Colors.redAccent,
                ),
              ),
              Align(
                alignment: Alignment(0, 0.2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                      maxRadius: 60,
                      // "https://i.pravatar.cc/300",
                      // borderWidth: 5.0,
                    ),
                    Text(
                      "Olá, ${snapshot.data.nome}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              TopBar(),
            ],
          ),
        ) : Container();
      }
    );
  }
}
