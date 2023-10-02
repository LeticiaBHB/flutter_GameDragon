import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  double positionX = 0;
  double positionY = 0;
  final double stepSize = 10.0; // Tamanho do passo
  double imageSize = 100.0; // Tamanho da imagem, ajuste conforme necessário

  List<String> actor = [
    'assets/actor_right.png',
    'assets/actor_left.png',
  ];
  int currentActorIndex = 0; // Inicializa com a primeira imagem

  List<String> Powers =[
    'assets/fire.png',
    'assets/ice.png',
  ];

  int currentPowersIndex = 0; // Inicializa com a primeira imagem

  void moveLeft() {
    setState(() {
      positionX = (positionX - stepSize)
          .clamp(0.0, MediaQuery.of(context).size.width - imageSize);
      currentActorIndex = 1; // Altera para a imagem da esquerda
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
      currentActorIndex = 0; // Altera para a imagem da direita
    });
  }

  void fire() {
    setState(() {
      currentPowersIndex = 0;
    });
  }

  void ice() {
    setState(() {
      currentPowersIndex = 3;
    });
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
              child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      left: positionX,
                      top: positionY,
                      child: Container(
                        width: imageSize,
                        height: imageSize,
                        child: Image.asset(actor[currentActorIndex]), // Use o índice atual para exibir a imagem correta
                      ),
                    ),
                  ],
                ),
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
                        SizedBox(height: 30), // Espaçamento entre os botões
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
                    SizedBox(width: 100),
                    ElevatedButton(
                      onPressed: fire,
                      child: Icon(Icons.local_fire_department),
                    ),
                    ElevatedButton(
                      onPressed: ice,
                      child: Icon(Icons.ac_unit),
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
