import 'package:flutter/material.dart';
import 'dart:math';

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
    'assets/water.png',
    'assets/ice.png',
  ];

  int lives = 3; // Add this line to keep track of lives

  void moveLeft() {
    setState(() {
      positionX = (positionX - stepSize)
          .clamp(0.0, MediaQuery.of(context).size.width - imageSize);
      currentActorIndex = 1;
      checkCollision();
    });
  }

  void moveUp() {
    setState(() {
      positionY = (positionY - stepSize)
          .clamp(0.0, MediaQuery.of(context).size.height - imageSize);
      checkCollision();
    });
  }

  void moveDown() {
    setState(() {
      positionY = (positionY + stepSize)
          .clamp(0.0, MediaQuery.of(context).size.height - imageSize);
      checkCollision();
    });
  }

  void moveRight() {
    setState(() {
      positionX = (positionX + stepSize)
          .clamp(0.0, MediaQuery.of(context).size.width - imageSize);
      currentActorIndex = 0;
      checkCollision();
    });
  }

  Widget buildRandomPowerWidget() {
    final random = Random();
    final randomPower = powers[random.nextInt(powers.length)];
    double randomPositionX;
    double randomPositionY;

    // Ensure that the new power's position doesn't overlap with the actor's position
    do {
      randomPositionX =
          random.nextDouble() * (MediaQuery.of(context).size.width - imageSize);
      randomPositionY =
          random.nextDouble() * (MediaQuery.of(context).size.height - imageSize);
    } while ((positionX - randomPositionX).abs() < imageSize &&
        (positionY - randomPositionY).abs() < imageSize);

    return Positioned(
      left: randomPositionX,
      top: randomPositionY,
      child: Container(
        width: imageSize,
        height: imageSize,
        child: GestureDetector(
          onTap: () {
            if ((positionX - randomPositionX).abs() < imageSize &&
                (positionY - randomPositionY).abs() < imageSize) {
              // Actor and power images are at the same position, decrement lives
              setState(() {
                lives -= 1;
              });
            }
          },
          child: Image.asset(randomPower),
        ),
      ),
    );
  }

  void checkCollision() {
    // Implement collision detection logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fundo2.jpeg'), // Substitua pelo caminho correto da sua imagem.
              fit: BoxFit.cover, // Ajuste conforme necessário.
            ),
          ),
          child: Column(
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
                      Expanded(
                          flex: 3,
                          child: Row(
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
                          )),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.health_and_safety),
                            Text("Lives: $lives"), // Display lives count
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
