import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PigGame(),
  ));
}

class PigGame extends StatefulWidget {
  PigGame({Key key}) : super(key: key);

  _PigGameState createState() => _PigGameState();
}

class _PigGameState extends State<PigGame> {
  var dices = [
    "assets/dice/dice-1.png",
    "assets/dice/dice-2.png",
    "assets/dice/dice-3.png",
    "assets/dice/dice-4.png",
    "assets/dice/dice-5.png",
    "assets/dice/dice-6.png",
  ];

  var currentDice = 0;
  var currentPlayer = 1;

  var winningPoint = 100;

  var playerPoints = {1: 0, 2: 0};

  var currentPoints = {1: 0, 2: 0};

  var playerStatus = {
    1: "Player 1",
    2: "Player 2"
  };

  var currentPlayerStyle = {1: Colors.blue, 2: Colors.transparent};

  rollDice() {
    Random rnd;
    int min = 0;
    int max = 6;
    rnd = Random();
    var r = min + rnd.nextInt(max - min) + 1;
    setState(() {
      this.currentDice = r - 1;
      this.currentPoints[currentPlayer] += r;
      if (r == 1) {
        swapPlayer();
      }
    });
  }

  hold() {
    setState(() {
      this.playerPoints[currentPlayer] += this.currentPoints[currentPlayer];
      this.currentPoints[this.currentPlayer] = 0;
      if (this.playerPoints[this.currentPlayer] >= this.winningPoint) {
        this.playerStatus[this.currentPlayer] = "Winner Winner";
      }else {
        swapPlayer();
      }
    });
  }

  swapPlayer() {
    this.currentPoints[this.currentPlayer] = 0;
    if (this.currentPlayer == 1) {
      this.currentPlayer = 2;
      this.currentPlayerStyle[2] = Colors.blue;
      this.currentPlayerStyle[1] = Colors.transparent;
    } else {
      this.currentPlayer = 1;
      this.currentPlayerStyle[1] = Colors.blue;
      this.currentPlayerStyle[2] = Colors.transparent;
    }
  }

  startNewGame() {
    setState(() {
      this.currentPlayer = 1;
      this.currentPoints[1] = 0;
      this.currentPoints[2] = 0;
      this.playerPoints[1] = 0;
      this.playerPoints[2] = 0;

      this.currentPlayerStyle[1] = Colors.blue;
      this.currentPlayerStyle[2] = Colors.transparent;

      this.playerStatus[1] = "Player 1";
      this.playerStatus[2] = "Player 2";
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(this.playerStatus[1]),
                            Container(
                                width: 10,
                                height: 10,
                                decoration: new BoxDecoration(
                                  color: this.currentPlayerStyle[1],
                                  shape: BoxShape.circle,
                                )),
                          ],
                        ),
                        Text(
                          "${this.playerPoints[1]}",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 10),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Current",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text("${this.currentPoints[1]}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        child: Text("New Game"),
                        onPressed: startNewGame,
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                        label: Text("Settings"),
                      ),
                      Card(
                        elevation: 2,
                        child: Container(
                          width: 100,
                          child: Image.asset(
                            this.dices[this.currentDice],
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Text("Roll Dice"),
                        onPressed: rollDice,
                      ),
                      FlatButton(
                        child: Text("Hold"),
                        onPressed: hold,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                          children: <Widget>[
                            Text(this.playerStatus[2]),
                            Container(
                                width: 10,
                                height: 10,
                                decoration: new BoxDecoration(
                                  color: this.currentPlayerStyle[2],
                                  shape: BoxShape.circle,
                                )),
                          ],
                        ),
                      Text(
                        "${this.playerPoints[2]}",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 20, right: 20, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Current",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text("${this.currentPoints[2]}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

