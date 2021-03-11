import 'package:flutter/material.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bem vindo: Nome do cara",
          style: TextStyle(fontFamily: "Courier", fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          SizedBox(
            height: 30,
          ),
          Card(
            child: InkWell(
              splashColor: Colors.white,
              onTap: (){
                Text("Chamar tela de detalhes do usuário");
              },
              child: Container(
                padding: EdgeInsets.all(20),
                width: 300,
                height: 200,
                child: ListView(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("Saldo atual",style: TextStyle(fontSize: 25,color: Colors.red),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("250",style: TextStyle(fontSize: 20,color: Colors.black),)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Card(
            child:InkWell(
              onTap: (){
                Text('Editar perfil do cara');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                width: 300,
                height: 150,
                child: ListView(
                  padding: EdgeInsets.all(5),
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Meu perfil",style: TextStyle(fontSize: 20,color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Nome",style: TextStyle(fontSize: 20,color: Colors.black),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                  Text("CPF",style: TextStyle(fontSize: 20,color: Colors.black),)
                  ],
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
}
