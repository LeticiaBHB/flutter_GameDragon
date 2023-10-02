import 'package:flutter/material.dart';
import 'package:game_td/Home.dart';
import 'package:game_td/engine/Game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (details) => MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red[300],
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_sharp,
                color: Colors.black, size: 100),
            const SizedBox(height: 20),
            SelectableText(
              details.exception.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "gameFlutter",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/Game': (context) => Game(),
      },
    );
  }
}