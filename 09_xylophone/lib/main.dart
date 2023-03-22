/**
 * Note: audioplayers package requires disabling of IPV6 (see: https://stackoverflow.com/questions/70960018/cocoapos-error-couldnt-determine-repo-type-for-url-https-cdn-cocoapod)
 */
import 'package:audioplayers/audioplayers.dart'; // used with audioplayers: ^3.0.1
import 'package:flutter/material.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  void playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(
      AssetSource('note$soundNumber.wav'),
    );
  }

  Expanded buildKey({required int keyNumber, required Color color}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 0),
          // or: minimumSize: Size.zero, padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          playSound(keyNumber);
        },
        child: Container(
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xylophone',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(keyNumber: 1, color: Colors.red),
              buildKey(keyNumber: 2, color: Colors.orange),
              buildKey(keyNumber: 3, color: Colors.yellow),
              buildKey(keyNumber: 4, color: Colors.green),
              buildKey(keyNumber: 5, color: Colors.teal),
              buildKey(keyNumber: 6, color: Colors.blue),
              buildKey(keyNumber: 7, color: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
