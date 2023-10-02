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

  List<String> images = [
    'assets/actor_right.png',
    'assets/actor_left.png',
    'assets/fire.png',
    'assets/ice.png',
  ];
  int currentImageIndex = 0; // Inicializa com a primeira imagem

  void moveLeft() {
    setState(() {
      positionX = (positionX - stepSize)
          .clamp(0.0, MediaQuery.of(context).size.width - imageSize);
      currentImageIndex = 1; // Altera para a imagem da esquerda
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
      currentImageIndex = 0; // Altera para a imagem da direita
    });
  }

  bool showFireImage = false;

  void fire() {
    setState(() {
      showFireImage = true; // Mostra a imagem de fogo
      currentImageIndex = 2;
    });

    // Aguarde 0.5 segundos e, em seguida, oculte a imagem de fogo
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        showFireImage = false;
        currentImageIndex = 1; // Volta para a imagem da esquerda após 0.5 segundos
      });
    });
  }

  bool showIceImage = false;

  void ice() {
    setState(() {
      showIceImage = true;
      currentImageIndex = 3;
    });

    // Aguarde 0.5 segundos e, em seguida, oculte a imagem de gelo
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        showIceImage = false;
        currentImageIndex = 0; // Volta para a imagem da direita após 0.5 segundos
      });
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
                        child: Image.asset(images[currentImageIndex]), // Use o índice atual para exibir a imagem correta
                      ),
                    ),
                    if (showFireImage || showIceImage)
                      Positioned(
                        left: currentImageIndex == 0 ? positionX + imageSize + 10 : positionX - imageSize - 10,
                        top: positionY,
                        child: Container(
                          width: imageSize,
                          height: imageSize,
                          child: Image.asset(
                            showFireImage ? images[2] : images[3], // Mostra a imagem de fogo ou gelo com base na ação
                          ),
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
