import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'card_component.dart';
import 'stack_container.dart';

class Perfil extends StatelessWidget {
  static const String homeName = "tela_home";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackContainer(),
            CardItem(
              'Saldo',
              Colors.black,
              '250.00',
              () {},
            ),
            SizedBox(
              height: 10,
            ),
            CardItem(
              'Nova transferência',
              Colors.black,
              '',
              () {},
            ),
            SizedBox(
              height: 10,
            ),
            CardItem(
              'Fatrura',
              Colors.black,
              '120',
                  () {},
            ),
          ],
        ),
      ),
    );
  }
}
