import 'package:flutter/material.dart';

class Button_login_inicial extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function aoClicar;

  Button_login_inicial({
    this.title,
    this.hasBorder,
    this.aoClicar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
            border: hasBorder
                ? Border.all(
              color: Colors.red,
              width: 1.0,
            )
                : Border.fromBorderSide(BorderSide.none)),
        child: InkWell(
          onTap: (){
            aoClicar(

            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
