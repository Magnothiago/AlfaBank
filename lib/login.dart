import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
              ),
            )
          ],
        ),
      )),
    );
  }
}
