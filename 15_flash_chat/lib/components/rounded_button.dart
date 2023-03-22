import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        //borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(
              color: color == Colors.white ? Colors.black54 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
