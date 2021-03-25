import 'package:flutter/material.dart';
import 'custom_cliper.dart';
import 'top_bar.dart';


class StackContainer extends StatelessWidget {
  const StackContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                // CircularProfileAvatar(
                //   "https://i.pravatar.cc/300",
                //   borderWidth: 5.0,
                // ),
                Text(
                  "Olá, Thiago",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
