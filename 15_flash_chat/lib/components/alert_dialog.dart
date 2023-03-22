import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryAlertDialog extends StatelessWidget {
  const BlurryAlertDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;
  final TextStyle textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

showAlertDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlurryAlertDialog(title: title, content: content);
    },
  );
}
