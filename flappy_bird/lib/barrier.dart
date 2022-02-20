import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierWidth; // out of 2, where 2 is the width of the screen
  final barrierHeight; // proportion of the screenheight
  final barrierX;
  final bool isThisBottomBarrier;

  MyBarrier(
      {this.barrierHeight,
        this.barrierWidth,
        required this.isThisBottomBarrier,
        this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green[700],
            boxShadow: [
        BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 1,


        offset: Offset(0, 0.5), // changes position of shadow
      ),
      ],
    ),
        width: MediaQuery.of(context).size.width * barrierWidth / 3,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,

      ),
    );
  }
}
