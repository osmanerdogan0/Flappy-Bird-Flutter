import 'dart:async';

import 'package:flutter/material.dart';

import 'barrier.dart';
import 'bird.dart';
import 'coverscreen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static double birdY=0;
  double initialPos=birdY;
  double height=0;
  double time=0;
  double gravity=-1.5;//yerçekimi
  double velocity=1.5;//zıplama gücü

  double birdWidth = 0.1;
  double birdHeight = 0.1;



  bool gameHasStarted=false;




  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5; // out of 2
  List<List<double>> barrierHeight = [
    // out of 2, where 2 is the entire height of the screen
    // [topHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6],
  ];



  void startGame(){
    gameHasStarted=true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      height=gravity*time*time+velocity*time;

      setState(() {
        birdY=initialPos-height;
      });

      if(birdIsDead()==true){
        timer.cancel();
        _showDialog();
      }


      moveMap();


      time+=0.1;
    });


  }



  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      // keep barriers moving
      setState(() {
        barrierX[i] -= 0.015;
      });

      // if barrier exits the left part of the screen, keep it looping
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }


  void jump(){
    setState(() {
      time=0;
      initialPos=birdY;
    });
  }

  bool birdIsDead(){
    if(birdY<-1||birdY>1){
      return true;
    }


    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }


    return false;
  }


  void resetGame(){
    Navigator.pop(context);
    setState(() {
      birdY=0;
      gameHasStarted=false;
      time=0;
      initialPos=birdY;

      barrierX = [1, 1 + 1.5];


    });
  }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,

        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(child: Text('Oyun bitti!',style: TextStyle(color:Colors.white),),),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.white,
                      child: Text(
                        'Yeniden oyna'
                            ,style: TextStyle(color: Colors.brown,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted?jump:startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue[500],

                child: Center(
                  child: Stack(
                    children: [
                     MyBird(birdY,birdWidth,birdHeight,),


                      MyCoverScreen(gameHasStarted: gameHasStarted),



                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),

                      // Bottom barrier 0
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),

                      // Top barrier 1
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),

                      // Bottom barrier 1
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'S K O R',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '10',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'T O P',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
