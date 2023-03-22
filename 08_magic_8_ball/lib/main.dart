import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BallPage(),
    ),
  );
}

class BallPage extends StatelessWidget {
  const BallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Ask Me Anything'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: const Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;
  final List<Color> colors = <Color>[
    Colors.greenAccent,
    Colors.redAccent,
    Colors.cyan,
    Colors.green,
    Colors.white54,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: colors[ballNumber],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextButton(
            onPressed: () {
              setState(() {
                ballNumber = Random().nextInt(5);
              });
            },
            child: Image.asset('assets/images/ball${ballNumber + 1}.png')),
      ),
    );
  }
}
