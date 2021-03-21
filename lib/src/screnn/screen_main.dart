import 'package:flutter/material.dart';

class TelaPrincipal extends StatelessWidget {
  static const String routeName = "tela_principal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text('Bem vindo'),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.attach_money_sharp,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Saldo',
                      style: TextStyle(fontSize: 25),
                    ),
                    subtitle: Text(
                      '250',
                      style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.attach_money_sharp,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Fatura',
                      style: TextStyle(fontSize: 25),
                    ),
                    subtitle: Text(
                      '170',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Meu Perfil',
                      style: TextStyle(fontSize: 25),
                    ),
                    //subtitle: Text(
                    //'170',
                    //style: TextStyle(fontSize: 18, color: Colors.red),
                    //),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.swap_horiz_sharp,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Transações',
                      style: TextStyle(fontSize: 25),
                    ),
                    //subtitle: Text(
                    //'170',
                    //style: TextStyle(fontSize: 18, color: Colors.red),
                    //),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
