import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.cyan[200],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Text(
                "GAME FLUTTER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  letterSpacing: 3,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.lightBlue[100],
                child: Image.asset('assets/fundo.jpeg'),
                margin: EdgeInsets.only(left: 0,top: 0,right: 0,bottom: 50),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/Game');
                    },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                    child: Text('START', style: TextStyle(color: Colors.black),
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