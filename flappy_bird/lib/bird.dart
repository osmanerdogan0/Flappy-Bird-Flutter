import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
 final birdY;
 final birdWidth;
 final birdHeight;

 MyBird(this.birdY, this.birdWidth, this.birdHeight);

  @override
  Widget build(BuildContext context) {


    return Container(
        alignment: Alignment(0, (2 * birdY + birdHeight) / (2 - birdHeight)),
        child: Image.asset(
          'lib/images/bird.png',
          width: MediaQuery.of(context).size.height * birdWidth / 2,
          height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
          fit: BoxFit.fill,
        ));
  }
}
