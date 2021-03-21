import 'package:flutter/material.dart';

class Saldo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Saldo Detalhado'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.redAccent,
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 300,
                child: ListView(
                  children: [
                    Text(
                      'Entradas',
                      style: (TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ted Itaú: 1.000,00',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Deposito: 250',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
