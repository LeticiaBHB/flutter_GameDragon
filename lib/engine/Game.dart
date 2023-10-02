import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Game(),
      ),
    );
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  double positionX = 0;
  double positionY = 0;
  final double stepSize = 10.0;
  double imageSize = 100.0;

  List<String> actor = [
    'assets/actor_right.png',
    'assets/actor_left.png',
  ];
  int currentActorIndex = 0;

  List<String> powers = [
    'assets/fire.png',
    'assets/ice.png',
  ];

  void moveLeft() {
    setState(() {
      positionX = (positionX - stepSize)
          .clamp(0.0, MediaQuery.of(context).size.width - imageSize);
      currentActorIndex = 1;
    });
  }

  void moveUp() {
    setState(() {
      positionY = (positionY - stepSize)
          .clamp(0.0, MediaQuery.of(context).size.height - imageSize);
    });
  }

  void moveDown() {
    setState(() {
      positionY = (positionY + stepSize)
          .clamp(0.0, MediaQuery.of(context).size.height - imageSize);
    });
  }

  void moveRight() {
    setState(() {
      positionX = (positionX + stepSize)
          .clamp(0.0, MediaQuery.of(context).size.width - imageSize);
      currentActorIndex = 0;
    });
  }

  Widget buildRandomPowerWidget() {
    final random = Random();
    final randomPower = powers[random.nextInt(powers.length)];
    final randomPositionX =
        random.nextDouble() * (MediaQuery.of(context).size.width - imageSize);
    final randomPositionY =
        random.nextDouble() * (MediaQuery.of(context).size.height - imageSize);

    return Positioned(
      left: randomPositionX,
      top: randomPositionY,
      child: Container(
        width: imageSize,
        height: imageSize,
        child: Image.asset(randomPower),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned(
                    left: positionX,
                    top: positionY,
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      child: Image.asset(actor[currentActorIndex]),
                    ),
                  ),
                  // Display random power inside the Positioned widget
                  buildRandomPowerWidget(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.lightBlue[200],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: moveLeft,
                      child: Text(
                        "🠔",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: moveUp,
                          child: Text(
                            "🠕",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: moveDown,
                          child: Text(
                            "🠗",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: moveRight,
                      child: Text(
                        "➞",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
